//
//  PSBaseDetailViewController.m
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSBaseDetailViewController.h"


@interface PSBaseDetailViewController ()
- (void)contextWillSave:(NSNotification *)notification;
@end


@implementation PSBaseDetailViewController

@synthesize		toolbar;
@synthesize		managedObjectContext;


- (void) configureView 
{	
	// [super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		// IMPLEMENT IN SUBCLASS: Update the user interface for the detail item.
	}
}


#pragma mark - Notification Processing

// Notification message from our managedObjectContext that it will save
- (void) contextWillSave:(NSNotification *)notification 
{	
	/*
	 // We might have been deleted; dismiss view in this case
	 if ( detailObject ) {
	 if ( [detailObject isDeleted] ) {
	 
	 // Tell the content controller to show the welcome screen
	 [[NSNotificationCenter defaultCenter] postNotificationName:ERSLoadDetailDisplayRequestedForItemNotification 
	 object:nil];
	 }
	 }
	 */
}


#pragma mark - View Lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{    
	[super viewDidLoad];
	
	[self configureView];
	
	// Listen for save events on the managedObjectContext, we might be deleted.
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc addObserver:self 
			selector:@selector(contextWillSave:) 
				name:NSManagedObjectContextWillSaveNotification 
			  object:managedObjectContext];
}


#pragma mark - Swappable Detail View Controller

- (void) showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
	if ( [itemsArray indexOfObject:barButtonItem] == NSNotFound ) {
		[itemsArray insertObject:barButtonItem atIndex:0];
		[toolbar setItems:itemsArray animated:NO];
	}
    [itemsArray release];
}

- (void) invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


#pragma mark - UITextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField 
{	
	// Dismiss the keyboard when they press return
	[textField resignFirstResponder];
	return NO;
}


#pragma mark - Rotation Support

// Ensure that the view controller supports rotation and that the split view can therefore
// show in both portrait and landscape.
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{    
	return YES;
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
	[super viewDidUnload];
	
	// Release any retained subviews of the main view. Or anything that can be recreated on viewDidLoad
    // e.g. self.myOutlet = nil;
	
	// Remove self as an observer.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	self.toolbar = nil;
}

- (void) dealloc 
{    
	// ERS_RELEASE_SAFELY( toolbar );
	ERS_RELEASE_SAFELY( managedObjectContext );
	
	[super dealloc];
}


@end
