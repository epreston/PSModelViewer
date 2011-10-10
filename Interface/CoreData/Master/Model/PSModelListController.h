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

@protected
    
	NSManagedObjectModel	*managedObjectModel_;
	
@private
    
	NSArray		*configNamesInModel_;
	NSArray		*entitiesInModel_;						
	NSArray		*fetchRequestTemplateNamesInModel_;
}

@property (nonatomic, retain) NSManagedObjectModel	*managedObjectModel;

@property (nonatomic, retain) NSArray	*configNamesInModel;
@property (nonatomic, retain) NSArray	*entitiesInModel;
@property (nonatomic, retain) NSArray	*fetchRequestTemplateNamesInModel;


@end
