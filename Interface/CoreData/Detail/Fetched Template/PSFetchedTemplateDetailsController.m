//
//  PSFetchedTemplateDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSFetchedTemplateDetailsController.h"


@interface PSFetchedTemplateDetailsController ()

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
		
		// TODO:
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
    self.entityClassName = nil;
    self.hasSubEntities = nil;
    
    [super viewDidUnload];
}

- (void) dealloc 
{    
	[detailFetchRequest_ release];
	
	[super dealloc];
}


@end
