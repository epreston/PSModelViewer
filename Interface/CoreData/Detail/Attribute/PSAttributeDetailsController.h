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


@interface PSAttributeDetailsController : PSBaseDetailViewController 
    < PSAcceptsAttributeDescription > 
{

	NSAttributeDescription		*detailAttributeDescription;
	
@private
	
	// Validation
	// – validationPredicates
	// – validationWarnings
	
	// Getting Features of a Property (common to all properties)
	UILabel							*relatedEntityName;
	UILabel							*propertyIsIndexed;
	UILabel							*propertyIsOptional;
	UILabel							*propertyIsTransient;
	UILabel							*propertyName;
	
	// Getting and Setting Type Information
	UILabel							*attributeType;
	UILabel							*attributeValueClassName;
	
	// Getting and Setting the Default Value
	UILabel							*attributeDefaultValue;
	
	// Value Transformers
	UILabel							*attributeValueTransformerName;
	
}

// Data objects
@property (nonatomic, retain) NSAttributeDescription		*detailAttributeDescription;

// Interface
@property (nonatomic, retain) IBOutlet UILabel				*relatedEntityName;
@property (nonatomic, retain) IBOutlet UILabel				*propertyIsIndexed;
@property (nonatomic, retain) IBOutlet UILabel				*propertyIsOptional;
@property (nonatomic, retain) IBOutlet UILabel				*propertyIsTransient;
@property (nonatomic, retain) IBOutlet UILabel				*propertyName;

@property (nonatomic, retain) IBOutlet UILabel				*attributeType;
@property (nonatomic, retain) IBOutlet UILabel				*attributeValueClassName;
@property (nonatomic, retain) IBOutlet UILabel				*attributeDefaultValue;
@property (nonatomic, retain) IBOutlet UILabel				*attributeValueTransformerName;

// Methods
- (void) configureView;
- (NSString *) nameFromAttributeType:(NSAttributeType)type;


@end
