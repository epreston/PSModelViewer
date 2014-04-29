//
//  PSRelationshipDetailsController.m
//  ModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSRelationshipDetailsController.h"


@implementation PSRelationshipDetailsController

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
        
        // Validation
        // – validationPredicates
        // – validationWarnings
		
        // Getting Features of a Property (common to all properties)
		_propertyName.text = [_detailRelationshipDescription name];
		_relatedEntityName.text = [[_detailRelationshipDescription entity] name];
		_propertyIsIndexed.text = ( _detailRelationshipDescription.isIndexed ) ? @"Yes" : @"No";
		_propertyIsOptional.text = ( _detailRelationshipDescription.isOptional ) ? @"Yes" : @"No";
		_propertyIsTransient.text = ( _detailRelationshipDescription.isTransient ) ? @"Yes" : @"No";
		
        // Managing Type Information
		_relationDestinationEntity.text = [[_detailRelationshipDescription destinationEntity] name];
		_relationInverseRelationship.text = [[_detailRelationshipDescription inverseRelationship] name];
		
        // Getting and Setting Delete Rules
		_relationDeleteRule.text = [self nameFromDeleteRuleType:[_detailRelationshipDescription deleteRule]];
		
        // Cardinality
		_relationMaxCount.text = [NSString stringWithFormat: @"%u", [_detailRelationshipDescription maxCount]];
		_relationMinCount.text = [NSString stringWithFormat: @"%u", [_detailRelationshipDescription minCount]];
		_relationIsToMany.text = ( _detailRelationshipDescription.isToMany ) ? @"Yes" : @"No";
	}
}


#pragma mark - Internal

- (NSString *) nameFromDeleteRuleType:(NSDeleteRule)type 
{
	switch (type) {
		case NSNoActionDeleteRule:
			return @"No Action";
			break;
		case NSNullifyDeleteRule:
			return @"Nullify";
			break;
		case NSCascadeDeleteRule:
			return @"Cascade";
			break;
		case NSDenyDeleteRule:
			return @"Deny";
			break;
		default:
			return @"Unknown";
			break;
	}
}


#pragma mark - UIViewController

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload
{
    self.relatedEntityName = nil;
    self.propertyIsIndexed = nil;
    self.propertyIsOptional = nil;
    self.propertyIsTransient = nil;
    self.propertyName = nil;
    self.relationDestinationEntity = nil;
    self.relationInverseRelationship = nil;
    self.relationDeleteRule = nil;
    self.relationMaxCount = nil;
    self.relationMinCount = nil;
    self.relationIsToMany = nil;
    
    [super viewDidUnload];
}


@end
