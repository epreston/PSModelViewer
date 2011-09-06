//
//  PSEntityDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSEntityDetailsController : PSBaseDetailViewController 
    < PSAcceptsEntityDescription > 
{	
	// NSEntityDescription
	NSEntityDescription			*detailEntityDescription;

@private
    
	// Information About an Entity Description
	UILabel							*entityName;
	UILabel							*entityManagedObjectClassName;
	UILabel							*entityIsAbstract;
	
	// Working with Properties
	//    – propertiesByName
	//    – properties
	//    – attributesByName
	//    – relationshipsByName
}

// Data object
@property (nonatomic, retain) NSEntityDescription			*detailEntityDescription;

// Interface
@property (nonatomic, retain) IBOutlet UILabel				*entityName;
@property (nonatomic, retain) IBOutlet UILabel				*entityManagedObjectClassName;
@property (nonatomic, retain) IBOutlet UILabel				*entityIsAbstract;

// Methods
- (void) configureView;


@end
