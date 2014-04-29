//
//  PSModelListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSModelListController.h"

#import <CoreData/CoreData.h>


@interface PSModelListController ()
{
    
@private
	NSArray		*_configNamesInModel;
	NSArray		*_entitiesInModel;						
	NSArray		*_fetchRequestTemplateNamesInModel;
}

@end


@implementation PSModelListController


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section ) {
		case 0:
			// Configurations
		{
			cell.textLabel.text = _configNamesInModel[indexPath.row];
		}
			break;
		case 1:
			// Entities
		{
			NSEntityDescription *entity = _entitiesInModel[indexPath.row];
			cell.textLabel.text = [entity name];
		}
			break;
		case 2:
			// Fetche Request Templates
		{
			cell.textLabel.text = _fetchRequestTemplateNamesInModel[indexPath.row];
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
	
	_entitiesInModel    = [self.managedObjectModel entities];
	_configNamesInModel = [self.managedObjectModel configurations];
	
	NSDictionary *namesLookup           = [self.managedObjectModel fetchRequestTemplatesByName];
	_fetchRequestTemplateNamesInModel   = [namesLookup allKeys];
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


#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Navigation logic here to create and push another view controller.
	
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
			if ( [_configNamesInModel count] ) {
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( _configNamesInModel[indexPath.row] );
			}
		}
			break;
		case 1:
			// Entities
		{
			if ( [_entitiesInModel count] ) {
				PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( _entitiesInModel[indexPath.row] );
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( _entitiesInModel[indexPath.row] );
			}
		}
			break;
		case 2:
			// Fetch Request Templates
		{
			if ( [_fetchRequestTemplateNamesInModel count] ) {
				NSString *selectedFetch = _fetchRequestTemplateNamesInModel[indexPath.row];
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
			if ( [_configNamesInModel count] ) {
				return [_configNamesInModel count];
			}
		}
			break;
		case 1:
			// Entities
		{
			if ( [_entitiesInModel count] ) {
				return [_entitiesInModel count];
			}
		}
			break;
		case 2:
			// Fetch Request Templates
		{
			if ( [_fetchRequestTemplateNamesInModel count] ) {
				return [_fetchRequestTemplateNamesInModel count];
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
    static NSString *CellIdentifier = @"PSModelListCell";
	static NSString *EmptyIdentifier = @"PSEmptyListCell";
	
	BOOL presentEmptyCell = NO;
    
	switch (indexPath.section) {
		case 0:
			// Configurations
			if ( ! [_configNamesInModel count] ) presentEmptyCell = YES;
			break;
		case 1:
			// Entities
			if ( ! [_entitiesInModel count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Fetch Request Template Properties
			if ( ! [_fetchRequestTemplateNamesInModel count] ) presentEmptyCell = YES;
			break;
			
		default:
			presentEmptyCell = YES;
			break;
	}
	
	UITableViewCell *cell = nil;
	
	if ( presentEmptyCell ) {
		cell = [tableView dequeueReusableCellWithIdentifier:EmptyIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:EmptyIdentifier];
			cell.textLabel.enabled = NO;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		
		cell.textLabel.text = @"Not defined.";
		
	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:CellIdentifier];
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

