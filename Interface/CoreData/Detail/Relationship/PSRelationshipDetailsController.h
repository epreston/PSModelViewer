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


@interface PSRelationshipDetailsController : PSBaseDetailViewController 
    < PSAcceptsRelationshipDescription > 
{
	
@private
    
    NSRelationshipDescription	*detailRelationshipDescription_;
	
	// Validation
	// – validationPredicates
	// – validationWarnings
	
	// Getting Features of a Property (common to all properties)
	UILabel		*relatedEntityName_;
	UILabel		*propertyIsIndexed_;
	UILabel		*propertyIsOptional_;
	UILabel		*propertyIsTransient_;
	UILabel		*propertyName_;
	
	// Managing Type Information
	UILabel		*relationDestinationEntity_;
	UILabel		*relationInverseRelationship_;
	
	// Getting and Setting Delete Rules
	UILabel		*relationDeleteRule_;
	
	// Cardinality
	UILabel		*relationMaxCount_;
	UILabel		*relationMinCount_;
	UILabel		*relationIsToMany_;
}

// Data Objects
@property (nonatomic, retain) NSRelationshipDescription		*detailRelationshipDescription;

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
