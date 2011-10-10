//
//  PSBaseDetailViewController.h
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PSBaseDetailViewController : UIViewController 
	< PSSwappableDetailView, PSAcceptsManagedObjectModel > 
// < PSSwappableDetailView, PSAcceptsManagedObjectContext > 
{

@private
    
	UIToolbar				*toolbar_;
//	NSManagedObjectContext	*managedObjectContext_;
    NSManagedObjectModel    *managedObjectModel_;
}

// PSAcceptsObjectContext
//@property (nonatomic, retain) NSManagedObjectContext	*managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel  *managedObjectModel;

// For convienience
@property (nonatomic, retain) IBOutlet UIToolbar        *toolbar;

// IMPLEMENT IN SUBCLASS: Update the user interface for the detail item.
- (void) configureView;

@end
