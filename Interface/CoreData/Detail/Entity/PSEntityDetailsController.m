//
//  PSEntityDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSEntityDetailsController.h"


@interface PSEntityDetailsController () 

// Methods
- (void) configureView;

@end


@implementation PSEntityDetailsController

// Data object
@synthesize detailEntityDescription         = detailEntityDescription_;

// Interface
@synthesize entityName                      = entityName_;
@synthesize entityManagedObjectClassName    = entityManagedObjectClassName_;
@synthesize entityIsAbstract                = entityIsAbstract_;

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		entityName_.text = [detailEntityDescription_ name];
		entityManagedObjectClassName_.text = [detailEntityDescription_ managedObjectClassName];
		entityIsAbstract_.text = ( detailEntityDescription_.isAbstract ) ? @"Yes" : @"No";
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
	ERS_RELEASE_SAFELY( detailEntityDescription_ );
	
	[super dealloc];
}


@end
