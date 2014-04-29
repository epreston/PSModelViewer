//
//  PSContentController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSBaseContentController.h"

#import <UIKit/UIKit.h>

@interface PSContentController : PSBaseContentController

- (UIViewController *) newMasterControllerFor:(NSObject *)anObject;
- (UIViewController *) newDetailControllerFor:(NSObject *)anObject;

@end
