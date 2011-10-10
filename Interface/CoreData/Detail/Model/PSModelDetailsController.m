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


@interface PSModelDetailsController ()

- (void) configureView;

@end


@implementation PSModelDetailsController

// Data object
//@synthesize managedObjectModel              = managedObjectModel_;

// Interface
@synthesize numberOfEntities                = numberOfEntities_;
@synthesize numberOfConfigurations          = numberOfConfigurations_;
@synthesize numberOfFetchRequestTemplates   = numberOfFetchRequestTemplates_;
@synthesize gridView                        = gridView_;


#define ITEM_WIDTH 172
#define ITEM_HEIGHT 197
#define ITEM_BORDER 5


- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
//		NSManagedObjectModel *model = [[self.managedObjectContext persistentStoreCoordinator] managedObjectModel];
        NSManagedObjectModel *model = self.managedObjectModel;
		
		numberOfEntities_.text = [NSString stringWithFormat: @"%u", [[model entities] count]];
		numberOfConfigurations_.text = [NSString stringWithFormat: @"%u", [[model configurations] count]];
		numberOfFetchRequestTemplates_.text = [NSString stringWithFormat: @"%u", [[model fetchRequestTemplatesByName] count]];
		
		// Set the item width and height
		self.gridView.itemWidth = ITEM_WIDTH;
		self.gridView.itemHeight = ITEM_HEIGHT;
		self.gridView.itemBorder = ITEM_BORDER;
		
        // Create auto-release pool
        NSAutoreleasePool * subPool = [[NSAutoreleasePool alloc] init];
        
        // NIB Caching to speed up load (iOS 4.0 and above only)
        cachedEntityViewNib = [[UINib nibWithNibName:@"PSSmallItemUI" bundle:[NSBundle mainBundle]] retain];
        
        // Store the loaded views in array
        NSMutableArray *views = [[NSMutableArray alloc] initWithCapacity:32];
    
        // Enumerate entities to generate the display
		NSArray *entities = [model entities];
		for (NSEntityDescription *entity in entities) {
			
            // Instantiate nib from cache
            NSArray *nibViews = [cachedEntityViewNib instantiateWithOwner:self options:nil];;
            
            if (nibViews) {
                // Add a new item to array
                PSSmallItemUI *smallItem = [nibViews objectAtIndex:0];
                
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
        
        // Populate the grid view display in on
        [self.gridView setGridViews:views];
        
        [views release];
        
        // Drain the pool
        [subPool release];
	}
}


#pragma mark - Resource Management

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{	
	self.numberOfEntities = nil;
	self.numberOfConfigurations = nil;
	self.numberOfFetchRequestTemplates = nil;
	
	self.gridView = nil;
    
    NSLog(@"unload");
    
    [super viewDidUnload];
}

- (void) dealloc 
{    
//	[managedObjectModel_ release];
	[cachedEntityViewNib release];
    
	[super dealloc];
}


#pragma mark - PSSmallItemUIDelegate 

- (void) performInfoAction: (PSSmallItemUI *)aSmallItem 
{	
//    NSManagedObjectModel *model = [[self.managedObjectContext persistentStoreCoordinator] managedObjectModel];
    NSManagedObjectModel *model = self.managedObjectModel;
    
    NSEntityDescription	*entity =  [model.entitiesByName objectForKey:aSmallItem.itemTitle.text];
    
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
