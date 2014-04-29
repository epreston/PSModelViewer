//
//  PSSplitViewDelegate.m
//  - Not project specific
//
//  Created by Ed Preston on 7/4/10.
//  Copyright 2010 Preston Software Inc. All rights reserved.
//

#import "PSSplitViewDelegate.h"
#import "PSDetailViewProtocols.h"

#define PS_BUTTON_TITLE @"Data Model Viewer"

NSString * const PSDismissPopoverRequestNotification = @"PSDismissPopover";
NSString * const PSConfirmPopoverRequestNotification = @"PSConfirmPopover";





@implementation PSSplitViewDelegate


#pragma mark - Internal

- (void) dismissPopoverRequested:(NSNotification *)notification 
{
    // Dismiss the popover if it's present.
    if (_popoverController != nil) {
        [_popoverController dismissPopoverAnimated:YES];
    }
	
    // Configure the new view controller's popover button (after the view has been displayed 
	// and its toolbar/navigation bar has been created).
    if (_rootPopoverButtonItem != nil) {
		// Find the current detail view controller, it might be holding a reference to this object
		UIViewController < PSSwappableDetailView > *detailViewController = (_splitViewController.viewControllers)[1];
		
		if (  [detailViewController conformsToProtocol:@protocol( PSSwappableDetailView )]  ) {
			[detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
		}
    }	
}

- (void) confirmPopoverRequested:(NSNotification *)notification 
{	
    // Configure the new view controller's popover button (after the view has been displayed and 
	// its toolbar/navigation bar has been created).
    if (_rootPopoverButtonItem != nil) {
		// Find the current detail view controller, it might be holding a reference to this object
		UIViewController < PSSwappableDetailView > *detailViewController = (_splitViewController.viewControllers)[1];
		
		if ( [detailViewController conformsToProtocol:@protocol( PSSwappableDetailView )] ) {
			[detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
		}
    }	
}


#pragma mark - Controller Lifecycle

- (void) awakeFromNib
{
	// Register the notification
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc addObserver:self 
			selector:@selector(dismissPopoverRequested:) 
				name:PSDismissPopoverRequestNotification 
			  object:nil];
	
	// Register the notification
	[dnc addObserver:self 
			selector:@selector(confirmPopoverRequested:) 
				name:PSConfirmPopoverRequestNotification 
			  object:nil];
	
	// Ensure that we are the delegate
	self.splitViewController.delegate = self;
}

- (void) dealloc
{
	// Remove self as an observer.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
}


#pragma mark - UISplitViewControllerDelegate

- (void) splitViewController:(UISplitViewController *)svc 
      willHideViewController:(UIViewController *)aViewController 
           withBarButtonItem:(UIBarButtonItem *)barButtonItem 
        forPopoverController:(UIPopoverController *)pc 
{    
    // Keep references to the popover controller and the popover button, and tell the detail view
    // controller to show the button.
    barButtonItem.title = PS_BUTTON_TITLE;
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    
    UIViewController < PSSwappableDetailView > *detailViewController = (svc.viewControllers)[1];
	if ( [detailViewController conformsToProtocol:@protocol( PSSwappableDetailView )] ) {
		[detailViewController showRootPopoverButtonItem:_rootPopoverButtonItem];
	}
}

- (void) splitViewController:(UISplitViewController *)svc 
      willShowViewController:(UIViewController *)aViewController 
   invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem 
{	
    // Nil out references to the popover controller and the popover button, and tell the detail 
    // view controller to hide the button.
    UIViewController < PSSwappableDetailView > *detailViewController = (svc.viewControllers)[1];
	if ( [detailViewController conformsToProtocol:@protocol( PSSwappableDetailView )] ) {
		[detailViewController invalidateRootPopoverButtonItem:_rootPopoverButtonItem];
	}
    
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}


@end
