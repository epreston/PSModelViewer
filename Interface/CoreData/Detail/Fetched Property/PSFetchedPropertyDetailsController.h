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
	
@private
    
    NSFetchedPropertyDescription	*detailFetchedPropertyDescription_;
    
    // Getting and Setting the Fetch Request
    // – fetchRequest
    
    // NOTE: See fetched template details for the fetch request
	
	// Validation
	// – validationPredicates
	// – validationWarnings
	
	// Getting Features of a Property (common to all properties)
	UILabel		*relatedEntityName_;
	UILabel		*propertyIsIndexed_;
	UILabel		*propertyIsOptional_;
	UILabel		*propertyIsTransient_;
	UILabel		*propertyName_;
}

// Data objects
@property (nonatomic, retain) NSFetchedPropertyDescription	*detailFetchedPropertyDescription;

// Interface
@property (nonatomic, assign) IBOutlet UILabel	*relatedEntityName;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsIndexed;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsOptional;
@property (nonatomic, assign) IBOutlet UILabel	*propertyIsTransient;
@property (nonatomic, assign) IBOutlet UILabel	*propertyName;

@end
