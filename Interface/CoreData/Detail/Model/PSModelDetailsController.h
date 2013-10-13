//
//  PSModelDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"
#import "PSSmallItemUI.h"


@class PSGridScrollView;


@interface PSModelDetailsController : PSBaseDetailViewController < PSSmallItemUIDelegate >

// Interface
@property (nonatomic, weak) IBOutlet UILabel			*numberOfEntities;
@property (nonatomic, weak) IBOutlet UILabel			*numberOfConfigurations;
@property (nonatomic, weak) IBOutlet UILabel			*numberOfFetchRequestTemplates;

@property (nonatomic, weak) IBOutlet PSGridScrollView	*gridView;

@end
