//
//  PSBaseDetailViewController.m
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSBaseDetailViewController.h"


@implementation PSBaseDetailViewController

@synthesize	toolbar                 = toolbar_;
@synthesize	managedObjectContext    = managedObjectContext_;


// IMPLEMENT IN SUBCLASS: Update the user interface for the detail item.

- (void) configureView 
{		
//	// The nib will overwrite our configuration if we are not loaded
//	if ( [self isViewLoaded] ) {
//		
//		
//	}
}


#pragma mark - View Lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{    
	[super viewDidLoad];
	
	[self configureView];
}

#pragma mark - Resource Management

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{		
	self.toolbar = nil;
    
    [super viewDidUnload];
}

- (void) dealloc 
{    
	[managedObjectContext_ release];
    
	[super dealloc];
}


#pragma mark - PSSwappableDetailView

- (void) showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [toolbar_.items mutableCopy];
	if ( [itemsArray indexOfObject:barButtonItem] == NSNotFound ) {
		[itemsArray insertObject:barButtonItem atIndex:0];
	} else {
        [itemsArray replaceObjectAtIndex:[itemsArray indexOfObject:barButtonItem] 
                              withObject:barButtonItem];
    }
    [toolbar_ setItems:itemsArray animated:NO];
    [itemsArray release];
}

- (void) invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar_.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar_ setItems:itemsArray animated:NO];
    [itemsArray release];
}


#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField 
{	
	// Dismiss the keyboard when they press return
	[textField resignFirstResponder];
	return NO;
}


#pragma mark - Rotation Support

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{   
    // Ensure that the view controller supports rotation and that the split view can therefore
    // show in both portrait and landscape.
    
	return YES;
}


@end
