//
//  PSFetchedTemplateDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSFetchedTemplateDetailsController : PSBaseDetailViewController 
    < PSAcceptsFetchRequest > 
{
	
@private
    
    NSFetchRequest	*detailFetchRequest_;
    
	// Entity
	UILabel			*entityName_;
	UILabel			*entityClassName_;
	UILabel			*hasSubEntities_;
	
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

// Data objects
@property (nonatomic, retain) NSFetchRequest	*detailFetchRequest;

// Interface
@property (nonatomic, assign) IBOutlet UILabel	*entityName;
@property (nonatomic, assign) IBOutlet UILabel	*entityClassName;
@property (nonatomic, assign) IBOutlet UILabel	*hasSubEntities;

@end
