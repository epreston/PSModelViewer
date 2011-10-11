//
//  PSModelListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSModelListController.h"


@interface PSModelListController ()

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation PSModelListController


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section ) {
		case 0:
			// Configurations
		{
			cell.textLabel.text = [configNamesInModel_ objectAtIndex:indexPath.row];
		}
			break;
		case 1:
			// Entities
		{
			NSEntityDescription *entity = [entitiesInModel_ objectAtIndex:indexPath.row];
			cell.textLabel.text = [entity name];
		}
			break;
		case 2:
			// Fetche Request Templates
		{
			cell.textLabel.text = [fetchRequestTemplateNamesInModel_ objectAtIndex:indexPath.row];
		}
			break;
			
		default:
			cell.textLabel.text = @"Error";
			break;
	}
}


#pragma mark - View Lifecycle

- (void) viewDidLoad 
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
	entitiesInModel_    = [[self.managedObjectModel entities] retain];
	configNamesInModel_ = [[self.managedObjectModel configurations] retain];
	
	NSDictionary *namesLookup           = [self.managedObjectModel fetchRequestTemplatesByName];
	fetchRequestTemplateNamesInModel_   = [[namesLookup allKeys] retain];
}


#pragma mark Resource Management

- (void) didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload 
{    
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	[super viewDidUnload];
}

- (void) dealloc
{
    [configNamesInModel_ release];
    [entitiesInModel_ release];
    [fetchRequestTemplateNamesInModel_ release];
    
    [super dealloc];
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Navigation logic may go here. Create and push another view controller.
	
	// Use the following macros:
	//
	// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( object );	// Load a detail display for this data 
	// PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( object );	// Load a list / navigation display for data
	//
	// PS_DISMISS_MAIN_POPOVER_IF_NEEDED( );		// Dismiss navigation popup in portrait
	//
	// PS_RESET_MASTER_DISPLAY( );					// Pops everthing off the stack of views
	// PS_RESET_DETAIL_DISPLAY( );					// Returns to the "home" display
	//
	
	switch (indexPath.section) {
		case 0:
			// Configurations
		{
			if ( [configNamesInModel_ count] ) {
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( [configNamesInModel_ objectAtIndex:indexPath.row] );
			}
		}
			break;
		case 1:
			// Entities
		{
			if ( [entitiesInModel_ count] ) {
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( [entitiesInModel_ objectAtIndex:indexPath.row] );
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( [entitiesInModel_ objectAtIndex:indexPath.row] );
			}
		}
			break;
		case 2:
			// Fetch Request Templates
		{
			if ( [fetchRequestTemplateNamesInModel_ count] ) {
				NSString *selectedFetch = [fetchRequestTemplateNamesInModel_ objectAtIndex:indexPath.row];
				NSFetchRequest *fetch = [self.managedObjectModel fetchRequestTemplateForName:selectedFetch];
				
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( fetch );
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( fetch );
			}
		}
			break;
			
		default:
			break;
	}
}


#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case 0:
			// Configurations
		{
			if ( [configNamesInModel_ count] ) {
				return [configNamesInModel_ count];
			}
		}
			break;
		case 1:
			// Entities
		{
			if ( [entitiesInModel_ count] ) {
				return [entitiesInModel_ count];
			}
		}
			break;
		case 2:
			// Fetch Request Templates
		{
			if ( [fetchRequestTemplateNamesInModel_ count] ) {
				return [fetchRequestTemplateNamesInModel_ count];
			}
		}
			break;

		default:
			break;
	}
	
	// When we have no information, we return 1 for an empty cell.
	return 1;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Customize the appearance of table view cells.
    static NSString *CellIdentifier = @"ModelListCell";
	static NSString *EmptyIdentifier = @"EmptyListCell";
	
	BOOL presentEmptyCell = NO;
    
	switch (indexPath.section) {
		case 0:
			// Configurations
			if ( ! [configNamesInModel_ count] ) presentEmptyCell = YES;
			break;
		case 1:
			// Entities
			if ( ! [entitiesInModel_ count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Fetch Request Template Properties
			if ( ! [fetchRequestTemplateNamesInModel_ count] ) presentEmptyCell = YES;
			break;
			
		default:
			presentEmptyCell = YES;
			break;
	}
	
	UITableViewCell *cell = nil;
	
	if ( presentEmptyCell ) {
		cell = [tableView dequeueReusableCellWithIdentifier:EmptyIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:EmptyIdentifier] autorelease];
			cell.textLabel.enabled = NO;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		
		cell.textLabel.text = @"Not defined.";
		
	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:CellIdentifier] autorelease];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
		}
		
		// Configure the cell.
		[self configureCell:cell atIndexPath:indexPath];
	}
    
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			// Configurations
			return @"Configurations";
			break;
		case 1:
			// Entities
			return @"Entities";
			break;
		case 2:
			// Fetch Request Template
			return @"Fetch Request Templates";
			break;
			
		default:
			return @"Error";
			break;
	}
}


@end

