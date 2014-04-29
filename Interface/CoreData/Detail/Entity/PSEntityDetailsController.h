//
//  PSEntityDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import	"PSBaseDetailViewController.h"

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PSEntityDetailsController : PSBaseDetailViewController < PSAcceptsEntityDescription >

// Data object
@property (nonatomic, strong) NSEntityDescription	*detailEntityDescription;

// Interface
@property (nonatomic, weak) IBOutlet UILabel		*entityName;
@property (nonatomic, weak) IBOutlet UILabel		*entityManagedObjectClassName;
@property (nonatomic, weak) IBOutlet UILabel		*entityIsAbstract;

@end
