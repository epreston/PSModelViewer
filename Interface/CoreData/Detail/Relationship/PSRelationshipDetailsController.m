//
//  PSRelationshipDetailsController.m
//  ModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSRelationshipDetailsController.h"


@interface PSRelationshipDetailsController ()

// Methods
- (void) configureView;
- (NSString *) nameFromDeleteRuleType:(NSDeleteRule)type;

@end


@implementation PSRelationshipDetailsController

// Data objects
@synthesize detailRelationshipDescription = detailRelationshipDescription_;

// Interface
@synthesize relatedEntityName   = relatedEntityName_;

@synthesize propertyIsIndexed   = propertyIsIndexed_;
@synthesize propertyIsOptional  = propertyIsOptional_;
@synthesize propertyIsTransient = propertyIsTransient_;
@synthesize propertyName        = propertyName_;

@synthesize relationDestinationEntity = relationDestinationEntity_;
@synthesize relationInverseRelationship = relationInverseRelationship_;
@synthesize relationDeleteRule  = relationDeleteRule_;
@synthesize relationMaxCount    = relationMaxCount_;
@synthesize relationMinCount    = relationMinCount_;
@synthesize relationIsToMany    = relationIsToMany_;

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		propertyName_.text = [detailRelationshipDescription_ name];
		relatedEntityName_.text = [[detailRelationshipDescription_ entity] name];
		propertyIsIndexed_.text = ( detailRelationshipDescription_.isIndexed ) ? @"Yes" : @"No";
		propertyIsOptional_.text = ( detailRelationshipDescription_.isOptional ) ? @"Yes" : @"No";
		propertyIsTransient_.text = ( detailRelationshipDescription_.isTransient ) ? @"Yes" : @"No";
		
		relationDestinationEntity_.text = [[detailRelationshipDescription_ destinationEntity] name];
		relationInverseRelationship_.text = [[detailRelationshipDescription_ inverseRelationship] name];
		
		relationDeleteRule_.text = [self nameFromDeleteRuleType:[detailRelationshipDescription_ deleteRule]];
		
		relationMaxCount_.text = [NSString stringWithFormat: @"%u", [detailRelationshipDescription_ maxCount]];
		relationMinCount_.text = [NSString stringWithFormat: @"%u", [detailRelationshipDescription_ minCount]];
		relationIsToMany_.text = ( detailRelationshipDescription_.isToMany ) ? @"Yes" : @"No";
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
	ERS_RELEASE_SAFELY( detailRelationshipDescription_ );
	
	[super dealloc];
}


@end
