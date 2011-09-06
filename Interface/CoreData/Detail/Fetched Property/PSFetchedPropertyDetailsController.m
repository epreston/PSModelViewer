//
//  PSFetchedPropertyDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSFetchedPropertyDetailsController.h"


@implementation PSFetchedPropertyDetailsController

// Data objects
@synthesize detailFetchedPropertyDescription;

// Interface
@synthesize relatedEntityName;
@synthesize propertyIsIndexed;
@synthesize propertyIsOptional;
@synthesize propertyIsTransient;
@synthesize propertyName;


- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		propertyName.text = [detailFetchedPropertyDescription name];
		relatedEntityName.text = [[detailFetchedPropertyDescription entity] name];
		propertyIsIndexed.text = ( detailFetchedPropertyDescription.isIndexed ) ? @"Yes" : @"No";
		propertyIsOptional.text = ( detailFetchedPropertyDescription.isOptional ) ? @"Yes" : @"No";
		propertyIsTransient.text = ( detailFetchedPropertyDescription.isTransient ) ? @"Yes" : @"No";
        
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
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailFetchedPropertyDescription );
	
	[super dealloc];
}


@end
