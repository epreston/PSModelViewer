//
//  PSFetchListController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSBaseMasterViewController.h"

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PSFetchListController : PSBaseMasterViewController < PSAcceptsFetchRequest > 

@property (nonatomic, strong) NSFetchRequest		*detailFetchRequest;

@end
