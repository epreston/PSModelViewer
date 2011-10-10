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
@synthesize managedObjectModel              = managedObjectModel_;

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
		
		NSManagedObjectModel *model = [[self.managedObjectContext persistentStoreCoordinator] managedObjectModel];
		
		numberOfEntities_.text = [NSString stringWithFormat: @"%u", [[model entities] count]];
		numberOfConfigurations_.text = [NSString stringWithFormat: @"%u", [[model configurations] count]];
		numberOfFetchRequestTemplates_.text = [NSString stringWithFormat: @"%u", [[model fetchRequestTemplatesByName] count]];
		
		// Set the item width and height
		self.gridView.itemWidth = ITEM_WIDTH;
		self.gridView.itemHeight = ITEM_HEIGHT;
		self.gridView.itemBorder = ITEM_BORDER;
		
		NSArray *entities = [model entities];
		NSArray *nibViews = nil;
        
        
        NSAutoreleasePool * subPool = [[NSAutoreleasePool alloc] init];
        
        // NIB Caching to speed up load (iOS 4.0 and above only)
        cachedEntityViewNib = [[UINib nibWithNibName:@"PSSmallItemUI" bundle:[NSBundle mainBundle]] retain];
        
		// Populate the grid item display
		for (NSEntityDescription *entity in entities) {
			
            nibViews = [cachedEntityViewNib instantiateWithOwner:self options:nil];;
            
            if (nibViews) {
                // Add a new item to array
                PSSmallItemUI *smallItem = [nibViews objectAtIndex:0];
                
                [self.gridView addViewToGrid:smallItem];
                
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
                
                //[previewText release];
                //[attributeNames release];
                
            }
		}
        
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
    
    [super viewDidUnload];
}

- (void) dealloc 
{    
	[managedObjectModel_ release];
	[cachedEntityViewNib release];
    
	[super dealloc];
}


#pragma mark - PSSmallItemUIDelegate 

- (void) performInfoAction: (PSSmallItemUI *)aSmallItem 
{	
	NSLog(@"Info button clicked.");	
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
