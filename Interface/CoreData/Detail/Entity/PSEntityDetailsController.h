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

@private
    
    NSEntityDescription	*detailEntityDescription_;
    
	// Information About an Entity Description
	UILabel			*entityName_;
	UILabel			*entityManagedObjectClassName_;
	UILabel			*entityIsAbstract_;
	
	// Working with Properties
	//    – propertiesByName
	//    – properties
	//    – attributesByName
	//    – relationshipsByName
}

// Data object
@property (nonatomic, retain) NSEntityDescription	*detailEntityDescription;

// Interface
@property (nonatomic, assign) IBOutlet UILabel		*entityName;
@property (nonatomic, assign) IBOutlet UILabel		*entityManagedObjectClassName;
@property (nonatomic, assign) IBOutlet UILabel		*entityIsAbstract;

@end
