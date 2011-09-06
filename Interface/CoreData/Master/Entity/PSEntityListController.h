//
//  PSEntityListController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "PSBaseMasterViewController.h"


@interface PSEntityListController : PSBaseMasterViewController 
    < PSAcceptsEntityDescription > 
{

	NSEntityDescription			*detailEntityDescription;
	
@private
    
	NSEntityDescription			*superEntityDescription;
	NSArray						*subEntityDescriptions;
	NSArray						*atrributesOfEntity;
	NSArray						*relationshipsOfEntity;
	NSMutableArray				*fetchedPropertiesOfEntity;
}


@property (nonatomic, retain) NSEntityDescription		*detailEntityDescription;

@property (nonatomic, retain) NSEntityDescription		*superEntityDescription;
@property (nonatomic, retain) NSArray					*subEntityDescriptions;
@property (nonatomic, retain) NSArray					*atrributesOfEntity;
@property (nonatomic, retain) NSArray					*relationshipsOfEntity;
@property (nonatomic, retain) NSArray					*fetchedPropertiesOfEntity;

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
