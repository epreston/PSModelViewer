//
//  PSFetchedPropertyDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSFetchedPropertyDetailsController.h"


@implementation PSFetchedPropertyDetailsController

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
        // Getting and Setting the Fetch Request
        // – fetchRequest
        
        // NOTE: See fetched template details for the fetch request
        
        // Validation
        // – validationPredicates
        // – validationWarnings
        
        // Getting Features of a Property (common to all properties)
        
		_propertyName.text = [_detailFetchedPropertyDescription name];
		_relatedEntityName.text = [[_detailFetchedPropertyDescription entity] name];
		_propertyIsIndexed.text = ( _detailFetchedPropertyDescription.isIndexed ) ? @"Yes" : @"No";
		_propertyIsOptional.text = ( _detailFetchedPropertyDescription.isOptional ) ? @"Yes" : @"No";
		_propertyIsTransient.text = ( _detailFetchedPropertyDescription.isTransient ) ? @"Yes" : @"No";
        
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
    
    [super viewDidUnload];
}


@end
