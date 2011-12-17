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
@property (nonatomic, assign) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, assign) IBOutlet UILabel	*propertyName;

@property (nonatomic, assign) IBOutlet UILabel	*relationDestinationEntity;
@property (nonatomic, assign) IBOutlet UILabel	*relationInverseRelationship;

@property (nonatomic, assign) IBOutlet UILabel	*relationDeleteRule;

@property (nonatomic, assign) IBOutlet UILabel	*relationMaxCount;
@property (nonatomic, assign) IBOutlet UILabel	*relationMinCount;
@property (nonatomic, assign) IBOutlet UILabel	*relationIsToMany;

@end
