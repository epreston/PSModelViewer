//
//  PSEntityDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSEntityDetailsController.h"


@implementation PSEntityDetailsController

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
        // Information About an Entity Description
		_entityName.text = [_detailEntityDescription name];
		_entityManagedObjectClassName.text = [_detailEntityDescription managedObjectClassName];
		_entityIsAbstract.text = ( _detailEntityDescription.isAbstract ) ? @"Yes" : @"No";
        
        // Working with Properties
        //    – propertiesByName
        //    – properties
        //    – attributesByName
        //    – relationshipsByName
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
	self.entityName = nil;
	self.entityManagedObjectClassName = nil;
	self.entityIsAbstract = nil;
    
    [super viewDidUnload];
}


@end
