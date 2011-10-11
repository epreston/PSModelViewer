//
//  PSEntityDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSEntityDetailsController.h"


@interface PSEntityDetailsController () 

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
}

- (void) viewDidUnload 
{
	self.entityName = nil;
	self.entityManagedObjectClassName = nil;
	self.entityIsAbstract = nil;
    
    [super viewDidUnload];
}

- (void) dealloc 
{    
	[detailEntityDescription_ release];
	
	[super dealloc];
}


@end
