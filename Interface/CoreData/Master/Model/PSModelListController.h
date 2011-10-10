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

@private
    NSManagedObjectModel	*managedObjectModel_;
    
	NSArray		*configNamesInModel_;
	NSArray		*entitiesInModel_;						
	NSArray		*fetchRequestTemplateNamesInModel_;
}

@property (nonatomic, retain) NSManagedObjectModel	*managedObjectModel;

@end
