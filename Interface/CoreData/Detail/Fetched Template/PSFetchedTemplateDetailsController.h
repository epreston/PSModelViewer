//
//  PSFetchedTemplateDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSFetchedTemplateDetailsController : PSBaseDetailViewController < PSAcceptsFetchRequest >

// Data objects
@property (nonatomic, strong) NSFetchRequest	*detailFetchRequest;

// Interface
@property (nonatomic, weak) IBOutlet UILabel	*entityName;
@property (nonatomic, weak) IBOutlet UILabel	*entityClassName;
@property (nonatomic, weak) IBOutlet UILabel	*hasSubEntities;

@end
