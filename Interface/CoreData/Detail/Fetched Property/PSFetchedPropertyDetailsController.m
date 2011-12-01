//
//  PSFetchedPropertyDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSFetchedPropertyDetailsController.h"


@interface PSFetchedPropertyDetailsController ()
{
	
@private
    NSFetchedPropertyDescription	*detailFetchedPropertyDescription_;
    
    // Getting and Setting the Fetch Request
    // – fetchRequest
    
    // NOTE: See fetched template details for the fetch request
	
	// Validation
	// – validationPredicates
	// – validationWarnings
	
	// Getting Features of a Property (common to all properties)
	UILabel		*relatedEntityName_;
	UILabel		*propertyIsIndexed_;
	UILabel		*propertyIsOptional_;
	UILabel		*propertyIsTransient_;
	UILabel		*propertyName_;
}

- (void) configureView;

@end


@implementation PSFetchedPropertyDetailsController

// Data objects
@synthesize detailFetchedPropertyDescription = detailFetchedPropertyDescription_;

// Interface
@synthesize relatedEntityName   = relatedEntityName_;
@synthesize propertyIsIndexed   = propertyIsIndexed_;
@synthesize propertyIsOptional  = propertyIsOptional_;
@synthesize propertyIsTransient = propertyIsTransient_;
@synthesize propertyName        = propertyName_;


- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		propertyName_.text = [detailFetchedPropertyDescription_ name];
		relatedEntityName_.text = [[detailFetchedPropertyDescription_ entity] name];
		propertyIsIndexed_.text = ( detailFetchedPropertyDescription_.isIndexed ) ? @"Yes" : @"No";
		propertyIsOptional_.text = ( detailFetchedPropertyDescription_.isOptional ) ? @"Yes" : @"No";
		propertyIsTransient_.text = ( detailFetchedPropertyDescription_.isTransient ) ? @"Yes" : @"No";
        
	}
}


#pragma mark - Resource Management

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
    
    [super viewDidUnload];
}

- (void) dealloc 
{    
	[detailFetchedPropertyDescription_ release];
	
	[super dealloc];
}


@end
