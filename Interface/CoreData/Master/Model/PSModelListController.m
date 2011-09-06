//
//  PSModelListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSModelListController.h"


@implementation PSModelListController

@synthesize managedObjectModel;
@synthesize configNamesInModel, entitiesInModel, fetchRequestTemplateNamesInModel;


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section ) {
		case 0:
			// Configurations
		{
			cell.textLabel.text = [configNamesInModel objectAtIndex:indexPath.row];
		}
			break;
		case 1:
			// Entities
		{
			NSEntityDescription *entity = [entitiesInModel objectAtIndex:indexPath.row];
			cell.textLabel.text = [entity name];
		}
			break;
		case 2:
			// Fetche Request Templates
		{
			cell.textLabel.text = [fetchRequestTemplateNamesInModel objectAtIndex:indexPath.row];
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
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSManagedObjectModel *model = [[self.managedObjectContext persistentStoreCoordinator] managedObjectModel];
	
	entitiesInModel = [[model entities] retain];
	configNamesInModel = [[model configurations] retain];
	
	NSDictionary *namesLookup = [model fetchRequestTemplatesByName];
	fetchRequestTemplateNamesInModel = [[namesLookup allKeys] retain];
}


#pragma mark - Table View Delegate

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
	
	//NSEntityDescription *entity = [subEntityDescriptions objectAtIndex:indexPath.row];
	//cell.textLabel.text = [entity name];
	//cell.detailTextLabel.text = [entity managedObjectClassName];
	
	switch (indexPath.section) {
		case 0:
			// Configurations
		{
			if ( [configNamesInModel count] ) {
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( [configNamesInModel objectAtIndex:indexPath.row] );
			}
		}
			break;
		case 1:
			// Entities
		{
			if ( [entitiesInModel count] ) {
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( [entitiesInModel objectAtIndex:indexPath.row] );
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( [entitiesInModel objectAtIndex:indexPath.row] );
			}
		}
			break;
		case 2:
			// Fetch Request Templates
		{
			if ( [fetchRequestTemplateNamesInModel count] ) {
				NSManagedObjectModel *model = [[self.managedObjectContext persistentStoreCoordinator] managedObjectModel];
				NSString *selectedFetch = [fetchRequestTemplateNamesInModel objectAtIndex:indexPath.row];
				NSFetchRequest *fetch = [[model fetchRequestTemplateForName:selectedFetch ] retain];
				
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( fetch );
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( fetch );
			}
		}
			break;
			
		default:
			break;
	}
}


#pragma mark - Table View Data Source

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
			if ( [configNamesInModel count] ) {
				return [configNamesInModel count];
			}
		}
			break;
		case 1:
			// Entities
		{
			if ( [entitiesInModel count] ) {
				return [entitiesInModel count];
			}
		}
			break;
		case 2:
			// Fetch Request Templates
		{
			if ( [fetchRequestTemplateNamesInModel count] ) {
				return [fetchRequestTemplateNamesInModel count];
			}
		}
			break;

		default:
			break;
	}
	
	// When we have no information, we return 1 for an empty cell.
	return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ModelListCell";
	static NSString *EmptyIdentifier = @"EmptyListCell";
	
	BOOL presentEmptyCell = NO;
    
	switch (indexPath.section) {
		case 0:
			// Configurations
			if ( ! [configNamesInModel count] ) presentEmptyCell = YES;
			break;
		case 1:
			// Entities
			if ( ! [entitiesInModel count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Fetch Request Template Properties
			if ( ! [fetchRequestTemplateNamesInModel count] ) presentEmptyCell = YES;
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


#pragma mark Resource Management

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
	
	ERS_RELEASE_SAFELY( entitiesInModel );
	ERS_RELEASE_SAFELY( configNamesInModel );
	ERS_RELEASE_SAFELY( fetchRequestTemplateNamesInModel );
}

- (void) dealloc 
{	
	ERS_RELEASE_SAFELY( managedObjectModel );
    
    [super dealloc];
}


@end

