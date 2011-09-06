//
//  PSFetchListController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


#import "PSBaseMasterViewController.h"



@interface PSFetchListController : PSBaseMasterViewController 
    < PSAcceptsFetchRequest > 
{

	NSFetchRequest				*detailFetchRequest;
	
@private
    
	NSEntityDescription			*fetchEntityDescription;
	NSArray						*affectedPersistantStores;
	NSArray						*orderedSortDescriptors;
	NSArray						*keyPathNamesForPrefetching;
	NSArray						*propertyDescriptionsToFetch;
}

@property (nonatomic, retain) NSFetchRequest				*detailFetchRequest;

@property (nonatomic, retain) NSEntityDescription			*fetchEntityDescription;
@property (nonatomic, retain) NSArray						*affectedPersistantStores;
@property (nonatomic, retain) NSArray						*orderedSortDescriptors;
@property (nonatomic, retain) NSArray						*keyPathNamesForPrefetching;
@property (nonatomic, retain) NSArray						*propertyDescriptionsToFetch;

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
