//
//  PSContentController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "PSBaseContentController.h"


@interface PSContentController : PSBaseContentController 
{

@private
    UIViewController	*currentMasterViewController_;
	UIViewController    *currentDetailViewController_;
	NSObject			*lastMasterObject_;
	NSObject			*lastDetailObject_;
}

@property (nonatomic, retain) IBOutlet	UIViewController	*currentMasterViewController;
@property (nonatomic, retain) IBOutlet	UIViewController	*currentDetailViewController;

@property (nonatomic, retain)			NSObject			*lastMasterObject;
@property (nonatomic, retain)			NSObject			*lastDetailObject;


- (UIViewController *) masterDisplayControllerFor:(NSObject *)anObject;
- (UIViewController *) detailDisplayControllerFor:(NSObject *)anObject;


@end
