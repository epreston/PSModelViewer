//
//  PSModelListController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "PSBaseMasterViewController.h"


@interface PSModelListController : PSBaseMasterViewController 
    < PSAcceptsManagedObjectModel > 
{

	NSManagedObjectModel			*managedObjectModel;
	
@private
    
	NSArray							*configNamesInModel;
	NSArray							*entitiesInModel;						
	NSArray							*fetchRequestTemplateNamesInModel;
}

@property (nonatomic, retain) NSManagedObjectModel			*managedObjectModel;

@property (nonatomic, retain) NSArray						*configNamesInModel;
@property (nonatomic, retain) NSArray						*entitiesInModel;
@property (nonatomic, retain) NSArray						*fetchRequestTemplateNamesInModel;

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
