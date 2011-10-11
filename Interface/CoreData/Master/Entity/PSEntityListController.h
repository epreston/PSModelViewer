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

@protected
    
	NSEntityDescription		*detailEntityDescription_;
	
@private
    
	NSEntityDescription		*superEntityDescription_;
	NSArray					*subEntityDescriptions_;
	NSArray					*atrributesOfEntity_;
	NSArray					*relationshipsOfEntity_;
	NSMutableArray			*fetchedPropertiesOfEntity_;
}

@property (nonatomic, retain) NSEntityDescription	*detailEntityDescription;

@end
