//
//  PSRelationshipDetailsController.h
//  ModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSRelationshipDetailsController : PSBaseDetailViewController < PSAcceptsRelationshipDescription >

// Data Objects
@property (nonatomic, strong) NSRelationshipDescription		*detailRelationshipDescription;

// Interface
@property (nonatomic, weak) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, weak) IBOutlet UILabel	*propertyName;

@property (nonatomic, weak) IBOutlet UILabel	*relationDestinationEntity;
@property (nonatomic, weak) IBOutlet UILabel	*relationInverseRelationship;

@property (nonatomic, weak) IBOutlet UILabel	*relationDeleteRule;

@property (nonatomic, weak) IBOutlet UILabel	*relationMaxCount;
@property (nonatomic, weak) IBOutlet UILabel	*relationMinCount;
@property (nonatomic, weak) IBOutlet UILabel	*relationIsToMany;

@end
