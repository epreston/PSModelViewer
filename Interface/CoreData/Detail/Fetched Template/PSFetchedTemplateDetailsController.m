//
//  PSFetchedTemplateDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSFetchedTemplateDetailsController.h"


@interface PSFetchedTemplateDetailsController ()

// Methods
- (void) configureView;

@end


@implementation PSFetchedTemplateDetailsController

// Data Objects
@synthesize detailFetchRequest = detailFetchRequest_;

// Interface
@synthesize entityName      = entityName_;
@synthesize entityClassName = entityClassName_;
@synthesize hasSubEntities  = hasSubEntities_;

- (void) configureView 
{
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		// IMPLEMENT IN SUBCLASS: Update the user interface for the detail item.
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
	self.entityClassName = nil;
	self.hasSubEntities = nil;
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailFetchRequest_ );
	
	[super dealloc];
}


@end
