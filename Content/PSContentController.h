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
}

@property (nonatomic, assign) IBOutlet	UIViewController	*currentMasterViewController;
@property (nonatomic, assign) IBOutlet	UIViewController	*currentDetailViewController;

- (UIViewController *) masterDisplayControllerFor:(NSObject *)anObject;
- (UIViewController *) detailDisplayControllerFor:(NSObject *)anObject;

@end
