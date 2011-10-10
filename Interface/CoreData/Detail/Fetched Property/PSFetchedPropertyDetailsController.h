//
//  PSFetchedPropertyDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"


@interface PSFetchedPropertyDetailsController : PSBaseDetailViewController 
    < PSAcceptsFetchedPropertyDescription > 
{

@protected
    
	NSFetchedPropertyDescription	*detailFetchedPropertyDescription_;
	
	/*
	 /////// NSFetchedPropertyDescription
	 
	 // Getting and Setting the Fetch Request
	 – fetchRequest
	 
	 // NOTE: See fetched template details for the fetch request
	 */
	
@private
	
	// Validation
	// – validationPredicates
	// – validationWarnings
	
	// Getting Features of a Property (common to all properties)
	UILabel			*relatedEntityName_;
	UILabel			*propertyIsIndexed_;
	UILabel			*propertyIsOptional_;
	UILabel			*propertyIsTransient_;
	UILabel			*propertyName_;
}

// Data objects
@property (nonatomic, retain) NSFetchedPropertyDescription	*detailFetchedPropertyDescription;

// Interface
@property (nonatomic, retain) IBOutlet UILabel		*relatedEntityName;
@property (nonatomic, retain) IBOutlet UILabel		*propertyIsIndexed;
@property (nonatomic, retain) IBOutlet UILabel		*propertyIsOptional;
@property (nonatomic, retain) IBOutlet UILabel		*propertyIsTransient;
@property (nonatomic, retain) IBOutlet UILabel		*propertyName;


@end
