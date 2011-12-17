//
//  PSAttributeDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSAttributeDetailsController : PSBaseDetailViewController < PSAcceptsAttributeDescription >

// Data objects
@property (nonatomic, strong) NSAttributeDescription	*detailAttributeDescription;

// Interface
@property (nonatomic, assign) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, assign) IBOutlet UILabel	*propertyName;

@property (nonatomic, assign) IBOutlet UILabel	*attributeType;
@property (nonatomic, assign) IBOutlet UILabel	*attributeValueClassName;
@property (nonatomic, assign) IBOutlet UILabel	*attributeDefaultValue;
@property (nonatomic, assign) IBOutlet UILabel	*attributeValueTransformerName;


@end
