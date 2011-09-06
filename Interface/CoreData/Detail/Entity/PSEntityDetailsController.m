//
//  PSEntityDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSEntityDetailsController.h"


@implementation PSEntityDetailsController

// Data object
@synthesize detailEntityDescription;

// Interface
@synthesize entityName;
@synthesize entityManagedObjectClassName;
@synthesize entityIsAbstract;

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		entityName.text = [detailEntityDescription name];
		entityManagedObjectClassName.text = [detailEntityDescription managedObjectClassName];
		entityIsAbstract.text = ( detailEntityDescription.isAbstract ) ? @"Yes" : @"No";
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
	
	self.entityName = nil;
	self.entityManagedObjectClassName = nil;
	self.entityIsAbstract = nil;
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailEntityDescription );
	
	[super dealloc];
}


@end
