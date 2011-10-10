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

@protected
    
	NSRelationshipDescription	*detailRelationshipDescription_;
	
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
@property (nonatomic, retain) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, retain) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, retain) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, retain) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, retain) IBOutlet UILabel	*propertyName;

@property (nonatomic, retain) IBOutlet UILabel	*relationDestinationEntity;
@property (nonatomic, retain) IBOutlet UILabel	*relationInverseRelationship;

@property (nonatomic, retain) IBOutlet UILabel	*relationDeleteRule;

@property (nonatomic, retain) IBOutlet UILabel	*relationMaxCount;
@property (nonatomic, retain) IBOutlet UILabel	*relationMinCount;
@property (nonatomic, retain) IBOutlet UILabel	*relationIsToMany;


@end
