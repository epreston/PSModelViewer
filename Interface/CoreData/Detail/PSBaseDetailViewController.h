//
//  PSBaseDetailViewController.h
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSDetailViewProtocols.h"
#import "PSCoreDataProtocols.h"

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PSBaseDetailViewController : UIViewController 
	< PSSwappableDetailView, PSAcceptsManagedObjectModel > 

@property (nonatomic, strong) NSManagedObjectModel  *managedObjectModel;
@property (nonatomic, weak) IBOutlet UIToolbar    *toolbar;

// IMPLEMENT IN SUBCLASS: Update the user interface for the detail item.
- (void) configureView;

@end
