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
@property (nonatomic, weak) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, weak) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, weak) IBOutlet UILabel	*propertyName;

@property (nonatomic, weak) IBOutlet UILabel	*attributeType;
@property (nonatomic, weak) IBOutlet UILabel	*attributeValueClassName;
@property (nonatomic, weak) IBOutlet UILabel	*attributeDefaultValue;
@property (nonatomic, weak) IBOutlet UILabel	*attributeValueTransformerName;


@end
