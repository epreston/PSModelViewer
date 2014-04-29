//
//  PSBaseDetailViewController.m
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSBaseDetailViewController.h"


@implementation PSBaseDetailViewController

// IMPLEMENT IN SUBCLASS: Update the user interface for the detail item.

- (void) configureView 
{		
//	// The nib will overwrite our configuration if we are not loaded
//	if ( [self isViewLoaded] ) {
//		
//		
//	}
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{    
	[super viewDidLoad];
	
	[self configureView];
}

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload 
{		
	self.toolbar = nil;
    
    [super viewDidUnload];
}


#pragma mark - PSSwappableDetailView

- (void) showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [_toolbar.items mutableCopy];
	if ( [itemsArray indexOfObject:barButtonItem] == NSNotFound ) {
		[itemsArray insertObject:barButtonItem atIndex:0];
	} else {
        // This may seem silly but is nessary, button will disappear when displaying the
        // detailViewController for a second time in portrait.
        itemsArray[[itemsArray indexOfObject:barButtonItem]] = barButtonItem;
    }
    [_toolbar setItems:itemsArray animated:NO];
}

- (void) invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [_toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [_toolbar setItems:itemsArray animated:NO];
}


#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField 
{	
	// Dismiss the keyboard when they press return
	[textField resignFirstResponder];
	return NO;
}


@end
