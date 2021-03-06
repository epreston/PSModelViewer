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


@interface PSEntityListController : PSBaseMasterViewController < PSAcceptsEntityDescription >

@property (nonatomic, strong) NSEntityDescription	*detailEntityDescription;

@end
