//
//  PSRelationshipDetailsController.m
//  ModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSRelationshipDetailsController.h"


@implementation PSRelationshipDetailsController

// Data objects
@synthesize detailRelationshipDescription;

// Interface
@synthesize relatedEntityName;
@synthesize propertyIsIndexed;
@synthesize propertyIsOptional;
@synthesize propertyIsTransient;
@synthesize propertyName;

@synthesize relationDestinationEntity;
@synthesize relationInverseRelationship;

@synthesize relationDeleteRule;

@synthesize relationMaxCount;
@synthesize relationMinCount;
@synthesize relationIsToMany;


- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		propertyName.text = [detailRelationshipDescription name];
		relatedEntityName.text = [[detailRelationshipDescription entity] name];
		propertyIsIndexed.text = ( detailRelationshipDescription.isIndexed ) ? @"Yes" : @"No";
		propertyIsOptional.text = ( detailRelationshipDescription.isOptional ) ? @"Yes" : @"No";
		propertyIsTransient.text = ( detailRelationshipDescription.isTransient ) ? @"Yes" : @"No";
		
		relationDestinationEntity.text = [[detailRelationshipDescription destinationEntity] name];
		relationInverseRelationship.text = [[detailRelationshipDescription inverseRelationship] name];
		
		relationDeleteRule.text = [self nameFromDeleteRuleType:[detailRelationshipDescription deleteRule]];
		
		relationMaxCount.text = [NSString stringWithFormat: @"%u", [detailRelationshipDescription maxCount]];
		relationMinCount.text = [NSString stringWithFormat: @"%u", [detailRelationshipDescription minCount]];
		relationIsToMany.text = ( detailRelationshipDescription.isToMany ) ? @"Yes" : @"No";
	}
}

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


#pragma mark - Resource Management

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{    
	[super viewDidUnload];
	
	// Release any retained subviews of the main view. Or anything that can be recreated on viewDidLoad
    // e.g. self.myOutlet = nil;
	
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
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailRelationshipDescription );
	
	[super dealloc];
}


@end
