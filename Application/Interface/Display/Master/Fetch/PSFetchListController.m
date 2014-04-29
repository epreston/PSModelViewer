//
//  PSFetchListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSFetchListController.h"


@interface PSFetchListController ()
{
	
@private
	NSEntityDescription		*_fetchEntityDescription;
	NSArray					*_affectedPersistantStores;
	NSArray					*_orderedSortDescriptors;
	NSArray					*_keyPathNamesForPrefetching;
	NSArray					*_propertyDescriptionsToFetch;
}

@end


@implementation PSFetchListController

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section) {
		case 0:
			// Search Entity
			cell.textLabel.text = [_fetchEntityDescription name];
			cell.detailTextLabel.text = [_fetchEntityDescription managedObjectClassName];
			break;
		case 1:
			// Affected Persistant Stores
		{
			NSPersistentStore *store = _affectedPersistantStores[indexPath.row];
			cell.textLabel.text = [store identifier];
			cell.detailTextLabel.text = [store type];
		}
			break;
		case 2:
			// Sort Descriptors
		{
			NSSortDescriptor *sort = _orderedSortDescriptors[indexPath.row];
			cell.textLabel.text = [sort key];
			if ( [sort ascending] ) {
				cell.detailTextLabel.text = @"ascending";
			} else {
				cell.detailTextLabel.text = @"decending";
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			cell.textLabel.text = _keyPathNamesForPrefetching[indexPath.row];
			
            NSEntityDescription *entity = (self.managedObjectModel.entitiesByName)[_keyPathNamesForPrefetching[indexPath.row]];
            
			if ( entity ) {
				cell.detailTextLabel.text = [entity name];
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			NSPropertyDescription *property = _propertyDescriptionsToFetch[indexPath.row];
			cell.textLabel.text = [property name];
			cell.detailTextLabel.text = @"see resultType";
		}
			break;
			
		default:
			cell.textLabel.text = @"Error";
			break;
	}
}


#pragma mark - UIViewController

- (void) viewDidLoad 
{
    [super viewDidLoad];
	
	if ( _detailFetchRequest ) {
		self.title = @"Fetch Request";
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
	_fetchEntityDescription         = [_detailFetchRequest entity];
	_affectedPersistantStores       = [_detailFetchRequest affectedStores];
	_orderedSortDescriptors         = [_detailFetchRequest sortDescriptors];
	_keyPathNamesForPrefetching     = [_detailFetchRequest relationshipKeyPathsForPrefetching];
	_propertyDescriptionsToFetch    = [_detailFetchRequest propertiesToFetch];
}

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
	//
	// Use the following macros:
	//
	// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( object );	// Load a detail display for this data 
	// PS_SHOW_MASTER_DISPLAY_FOR_OBJECT( object );	// Load a list / navigation display for data
	//
	// PS_DISMISS_MAIN_POPOVER_IF_NEEDED( );		// Dismiss navigation popup in portrait
	//
	// PS_RESET_MASTER_DISPLAY( );					// Pops everthing off the stack of views
	// PS_RESET_DETAIL_DISPLAY( );					// Returns to the "home" display
	
	switch (indexPath.section) {
		case 0:
			// Search Entity
			if ( _fetchEntityDescription ) {
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( _fetchEntityDescription );
			}
			break;
		case 1:
			// Affected Persistant Stores
		{
			if ( [_affectedPersistantStores count] ) {
				// NSEntityDescription *entity = [affectedPersistantStores objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 2:
			// Sort Descriptors
		{
			if ( [_orderedSortDescriptors count] ) {
				// NSEntityDescription *entity = [orderedSortDescriptors objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			if ( [_keyPathNamesForPrefetching count] ) {
				// NSEntityDescription *entity = [keyPathNamesForPrefetching objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			if ( [_propertyDescriptionsToFetch count] ) {
				// NSEntityDescription *entity = [propertyDescriptionsToFetch objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
			
		default:
			break;
	}
}


#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
	switch (section) {
		case 0:
			// Search Entity or place for message
			return 1;
			break;
		case 1:
			// Affected Persistant Stores
		{
			if ( [_affectedPersistantStores count] ) {
				return [_affectedPersistantStores count];
			}
		}
			break;
		case 2:
			// Sort Descriptors
		{
			if ( [_orderedSortDescriptors count] ) {
				return [_orderedSortDescriptors count];
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			if ( [_keyPathNamesForPrefetching count] ) {
				return [_keyPathNamesForPrefetching count];
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			if ( [_propertyDescriptionsToFetch count] ) {
				return [_propertyDescriptionsToFetch count];
			}
		}
			break;
			
		default:
			break;
	}
	
	// When we have no information, we return 1 for an empty cell.
	return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Customize the appearance of table view cells.
    static NSString *CellIdentifier = @"PSFetchListCell";
	static NSString *EmptyIdentifier = @"PSEmptyListCell";
	
	BOOL presentEmptyCell = NO;
	
	switch (indexPath.section) {
		case 0:
			// Search Entity
			if ( ! _fetchEntityDescription ) presentEmptyCell = YES;
			break;
		case 1:
			// Affected Persistant Stores
			if ( ! [_affectedPersistantStores count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Sort Descriptors
			if ( ! [_orderedSortDescriptors count] ) presentEmptyCell = YES;
			break;
		case 3:
			// Prefetch Keypaths
			if ( ! [_keyPathNamesForPrefetching count] ) presentEmptyCell = YES;
			break;
		case 4:
			// Properties to Fetch
			if ( ! [_propertyDescriptionsToFetch count] ) presentEmptyCell = YES;
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
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                           reuseIdentifier:CellIdentifier];
			// cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
		}
		
		// Configure the cell.
		[self configureCell:cell atIndexPath:indexPath];
	}
    
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	switch (section) {
		case 0:
			// Search Entity
			return @"Entity to Search";
			break;
		case 1:
			// Affected Persistant Stores
			return @"Stores to Search";
			break;
		case 2:
			// Sort Descriptors
			return @"Sort Descriptors";
			break;
		case 3:
			// Prefetch Keypaths
			return @"Relationships to Prefetch";
			break;
		case 4:
			// Properties to Fetch
			return @"Properties to Fetch";
			break;

		default:
			return @"Error";
			break;
	}
}


@end

