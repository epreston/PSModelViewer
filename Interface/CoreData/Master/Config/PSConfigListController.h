//
//  PSConfigListController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PSBaseMasterViewController.h"



@interface PSConfigListController : PSBaseMasterViewController 
    < PSAcceptsString > 
{

	NSString						*detailString;

@private
    
	NSArray							*entitiesInConfig;
}

@property (nonatomic, retain) NSString						*detailString;
@property (nonatomic, retain) NSArray						*entitiesInConfig;

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
