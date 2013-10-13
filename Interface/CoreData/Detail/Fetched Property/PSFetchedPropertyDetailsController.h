//
//  PSFetchedPropertyDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSFetchedPropertyDetailsController : PSBaseDetailViewController < PSAcceptsFetchedPropertyDescription >

// Data objects
@property (nonatomic, strong) NSFetchedPropertyDescription	*detailFetchedPropertyDescription;

// Interface
@property (nonatomic, weak) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, weak) IBOutlet UILabel	*propertyName;

@end
