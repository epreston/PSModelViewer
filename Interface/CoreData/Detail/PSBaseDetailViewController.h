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
	< PSSwappableDetailView, PSAcceptsManagedObjectContext > 
{

@private
    
	UIToolbar				*toolbar_;
	NSManagedObjectContext	*managedObjectContext_;
}

// For convienience
@property (nonatomic, assign) IBOutlet UIToolbar        *toolbar;

// PSAcceptsObjectContext
@property (nonatomic, retain) NSManagedObjectContext	*managedObjectContext;

- (void) configureView;

@end
