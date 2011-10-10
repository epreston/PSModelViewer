//
//  PSBaseMasterViewController.m
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSBaseMasterViewController.h"


@interface PSBaseMasterViewController ()

- (IBAction) showHomeDetailDisplay:(id)sender;

@end


@implementation PSBaseMasterViewController

@synthesize	managedObjectContext = managedObjectContext_;


// IMPLEMENT IN SUBCLASS: Update the cell text.
- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    cell.textLabel.text = @"Table Item";
}

// Shared interface actions
- (IBAction) showHomeDetailDisplay:(id)sender 
{
	PS_RESET_DETAIL_DISPLAY();
}


#pragma mark - View Lifecycle

- (void) viewDidLoad 
{    
	[super viewDidLoad];

    // preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
	
	// avoid display issues
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	// setup our toolbar buttons
	UIBarButtonItem *flexSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
																					 target:nil 
																					 action:nil];
	
	// Create a button and add it to the toolbar or navigation bar
	UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_home.png"]
																	   style:UIBarButtonItemStylePlain 
																	  target:self 
																	  action:@selector(showHomeDetailDisplay:)];
	
	// Add the button to the toolbar
	[self setToolbarItems:[NSArray arrayWithObjects:flexSpaceButton, homeButtonItem, nil] animated:YES];
	
	// Release the buttons we allocated
	[flexSpaceButton release];
	[homeButtonItem release];
}


#pragma mark - Resource Management

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void) viewDidUnload 
{    
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	[super viewDidUnload];
}

- (void)dealloc
{
    [managedObjectContext_ release];
    
    [super dealloc];
}


#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	// Request the correct type of detail view controller for this type of item.
	// NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	
	// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( selectedObject );
	
	// Dismiss the popover and manage the button
	PS_DISMISS_MAIN_POPOVER_IF_NEEDED();
	
}


#pragma mark - UITableViewDataSource

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	// The table view should not be re-orderable.
    return NO;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 
{	
	return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"BaseMasterViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                       reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Rotation Support

// Ensure that the view controller supports rotation and that the split view can therefore 
// show in both portrait and landscape.
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{    
	return YES;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
                                          duration:(NSTimeInterval)duration 
{
    // no popouts for lanscape orientation (use the MasterViewController's table)
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
		// This fixes the problem with losing theme on rotation
		self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
		self.navigationController.toolbar.barStyle = UIBarStyleBlack;
	}
}


@end

