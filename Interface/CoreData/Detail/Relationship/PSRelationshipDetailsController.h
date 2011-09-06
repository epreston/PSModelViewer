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

	NSRelationshipDescription		*detailRelationshipDescription;
	
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
	
	// Managing Type Information
	UILabel							*relationDestinationEntity;
	UILabel							*relationInverseRelationship;
	
	// Getting and Setting Delete Rules
	UILabel							*relationDeleteRule;
	
	// Cardinality
	UILabel							*relationMaxCount;
	UILabel							*relationMinCount;
	UILabel							*relationIsToMany;
}

// Data Objects
@property (nonatomic, retain) NSRelationshipDescription		*detailRelationshipDescription;

// Interface
@property (nonatomic, retain) IBOutlet UILabel				*relatedEntityName;
@property (nonatomic, retain) IBOutlet UILabel				*propertyIsIndexed;
@property (nonatomic, retain) IBOutlet UILabel				*propertyIsOptional;
@property (nonatomic, retain) IBOutlet UILabel				*propertyIsTransient;
@property (nonatomic, retain) IBOutlet UILabel				*propertyName;

@property (nonatomic, retain) IBOutlet UILabel				*relationDestinationEntity;
@property (nonatomic, retain) IBOutlet UILabel				*relationInverseRelationship;

@property (nonatomic, retain) IBOutlet UILabel				*relationDeleteRule;

@property (nonatomic, retain) IBOutlet UILabel				*relationMaxCount;
@property (nonatomic, retain) IBOutlet UILabel				*relationMinCount;
@property (nonatomic, retain) IBOutlet UILabel				*relationIsToMany;

// Methods
- (void) configureView;
- (NSString *) nameFromDeleteRuleType:(NSDeleteRule)type;


@end
