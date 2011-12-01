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
@property (nonatomic, retain) NSFetchRequest	*detailFetchRequest;

// Interface
@property (nonatomic, assign) IBOutlet UILabel	*entityName;
@property (nonatomic, assign) IBOutlet UILabel	*entityClassName;
@property (nonatomic, assign) IBOutlet UILabel	*hasSubEntities;

@end
