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
    
@protected

	NSAttributeDescription		*detailAttributeDescription_;
	
@private
	
	// Validation
	// – validationPredicates
	// – validationWarnings
	
	// Getting Features of a Property (common to all properties)
	UILabel		*relatedEntityName_;
	UILabel		*propertyIsIndexed_;
	UILabel		*propertyIsOptional_;
	UILabel		*propertyIsTransient_;
	UILabel		*propertyName_;
	
	// Getting and Setting Type Information
	UILabel		*attributeType_;
	UILabel		*attributeValueClassName_;
	
	// Getting and Setting the Default Value
	UILabel		*attributeDefaultValue_;
	
	// Value Transformers
	UILabel		*attributeValueTransformerName_;
	
}

// Data objects
@property (nonatomic, retain) NSAttributeDescription	*detailAttributeDescription;

// Interface
@property (nonatomic, retain) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, retain) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, retain) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, retain) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, retain) IBOutlet UILabel	*propertyName;

@property (nonatomic, retain) IBOutlet UILabel	*attributeType;
@property (nonatomic, retain) IBOutlet UILabel	*attributeValueClassName;
@property (nonatomic, retain) IBOutlet UILabel	*attributeDefaultValue;
@property (nonatomic, retain) IBOutlet UILabel	*attributeValueTransformerName;


@end
