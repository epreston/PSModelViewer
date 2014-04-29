//
//  PSFetchedTemplateDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSFetchedTemplateDetailsController.h"


@implementation PSFetchedTemplateDetailsController

- (void) configureView
{
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		// TODO:
        
        /*
         
         // Fetch Constraints
         – predicate
         – fetchLimit
         – fetchOffset
         – fetchBatchSize
         – affectedStores
         
         // Sorting
         – sortDescriptors
         
         // Prefetching
         – relationshipKeyPathsForPrefetching
         
         // Managing How Results Are Returned
         – resultType
         – includesPendingChanges
         – propertiesToFetch
         – returnsDistinctResults
         – includesPropertyValues
         – returnsObjectsAsFaults
         
         */
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
    self.entityName = nil;
    self.entityClassName = nil;
    self.hasSubEntities = nil;
    
    [super viewDidUnload];
}



@end
