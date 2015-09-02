//
//  PSModelDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSModelDetailsController.h"

#import "PSGridScrollView.h"
#import "PSSmallItemUI.h"

#import <CoreData/CoreData.h>


@interface PSModelDetailsController ()
{
    
@private
    
    // NIB Caching to speed up load (requires iOS 4.0 +)
    UINib               *cachedEntityViewNib;
}

@end


#define ITEM_WIDTH 172
#define ITEM_HEIGHT 197
#define ITEM_BORDER 5


@implementation PSModelDetailsController

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
        NSManagedObjectModel *model = self.managedObjectModel;
		
		_numberOfEntities.text = [NSString stringWithFormat: @"%lu", (unsigned long)[[model entities] count]];
		_numberOfConfigurations.text = [NSString stringWithFormat: @"%lu", (unsigned long)[[model configurations] count]];
		_numberOfFetchRequestTemplates.text = [NSString stringWithFormat: @"%lu", (unsigned long)[[model fetchRequestTemplatesByName] count]];
		
		// Set the item width and height
		self.gridView.itemWidth = ITEM_WIDTH;
		self.gridView.itemHeight = ITEM_HEIGHT;
		self.gridView.itemBorder = ITEM_BORDER;
		
        // Create auto-release pool
        @autoreleasepool {
        
            // NIB Caching to speed up load (iOS 4.0 and above only)
            cachedEntityViewNib = [UINib nibWithNibName:@"PSSmallItemUI" bundle:[NSBundle mainBundle]];
            
            // Store the loaded views in array
            NSMutableArray *views = [[NSMutableArray alloc] initWithCapacity:32];
        
            // Enumerate entities to generate the display
            NSArray *entities = [model entities];
            for (NSEntityDescription *entity in entities) {
                
                // Instantiate nib from cache
                NSArray *nibViews = [cachedEntityViewNib instantiateWithOwner:self options:nil];;
                
                if (nibViews) {
                    // Add a new item to array
                    PSSmallItemUI *smallItem = nibViews[0];
                    
                    // Configure the properties
                    smallItem.delegate = self;
                    smallItem.itemTitle.text = [entity name];
                    smallItem.itemSubTitle.text = [entity managedObjectClassName];
                    
                    
                    NSMutableString *previewText = [NSMutableString stringWithCapacity:255];
                    NSArray *attributeNames = [[entity attributesByName] allKeys] ;
                    
                    for ( NSString *name in attributeNames) {
                        [previewText appendFormat:@"%@\n", name];
                    }
                    
                    smallItem.itemDetails.text = previewText;
                    
                    // Add the view to the array
                    [views addObject:smallItem];
                }
            }
            
            // Populate the grid view display in bulk to run the layout code once.
            [self.gridView setGridViews:views];
            
        
        } // Drain the pool
	}
}


#pragma mark - UIViewController

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload 
{	
	self.numberOfEntities = nil;
	self.numberOfConfigurations = nil;
	self.numberOfFetchRequestTemplates = nil;
	
	self.gridView = nil;
    
    [super viewDidUnload];
}



#pragma mark - PSSmallItemUIDelegate 

- (void) performInfoAction: (PSSmallItemUI *)aSmallItem 
{
    NSManagedObjectModel *model = self.managedObjectModel;
    
    NSEntityDescription	*entity =  (model.entitiesByName)[aSmallItem.itemTitle.text];
    
    if (entity) {
        PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( entity );
        PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
    }
}


#pragma mark - Rotation Support

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
                                          duration:(NSTimeInterval)duration
{
	// Edge case where view is scrolling and orientation changes:
	// Need to update the display of the gridview
	
	[self.gridView setNeedsLayout];
}

@end
