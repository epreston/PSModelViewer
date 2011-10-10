//
//  PSSplitViewDelegate.h
//  - Not project specific
//
//  Created by Ed Preston on 7/4/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PSSplitViewDelegate : NSObject 
    < UISplitViewControllerDelegate > 
{
    
@private
    UISplitViewController	*splitViewController_;
	UIPopoverController		*popoverController_;    
    UIBarButtonItem			*rootPopoverButtonItem_;
}

@property (nonatomic, assign) IBOutlet UISplitViewController	*splitViewController;

@property (nonatomic, retain) UIPopoverController				*popoverController;
@property (nonatomic, retain) UIBarButtonItem					*rootPopoverButtonItem;


@end
