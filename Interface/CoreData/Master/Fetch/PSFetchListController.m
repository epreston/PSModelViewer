//
//  PSFetchListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSFetchListController.h"


@implementation PSFetchListController

@synthesize detailFetchRequest;

@synthesize	fetchEntityDescription;

@synthesize affectedPersistantStores, orderedSortDescriptors;
@synthesize keyPathNamesForPrefetching, propertyDescriptionsToFetch;


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section) {
		case 0:
			// Search Entity
			cell.textLabel.text = [fetchEntityDescription name];
			cell.detailTextLabel.text = [fetchEntityDescription managedObjectClassName];
			break;
		case 1:
			// Affected Persistant Stores
		{
			NSPersistentStore *store = [affectedPersistantStores objectAtIndex:indexPath.row];
			cell.textLabel.text = [store identifier];
			cell.detailTextLabel.text = [store type];
		}
			break;
		case 2:
			// Sort Descriptors
		{
			NSSortDescriptor *sort = [orderedSortDescriptors objectAtIndex:indexPath.row];
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
			cell.textLabel.text = [keyPathNamesForPrefetching objectAtIndex:indexPath.row];
			
			// we can pull the related class name for the key property
			NSEntityDescription *entity = [NSEntityDescription entityForName:[keyPathNamesForPrefetching objectAtIndex:indexPath.row]
													   inManagedObjectContext:managedObjectContext];
			if ( entity ) {
				cell.detailTextLabel.text = [entity name];
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			NSPropertyDescription *property = [propertyDescriptionsToFetch objectAtIndex:indexPath.row];
			cell.textLabel.text = [property name];
			cell.detailTextLabel.text = @"see resultType";
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
	
	if ( detailFetchRequest ) {
		
		self.title = @"Fetch Request";
		// self.title = [detailFetchRequest class];
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
	fetchEntityDescription = [detailFetchRequest entity];
	affectedPersistantStores = [[detailFetchRequest affectedStores] retain];
	orderedSortDescriptors = [[detailFetchRequest sortDescriptors] retain];
	keyPathNamesForPrefetching = [[detailFetchRequest relationshipKeyPathsForPrefetching] retain];
	propertyDescriptionsToFetch = [[detailFetchRequest propertiesToFetch] retain];
}


#pragma mark - Table View Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Navigation logic may go here. Create and push another view controller.
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
	//
	
	switch (indexPath.section) {
		case 0:
			// Search Entity
			if ( fetchEntityDescription ) {
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( fetchEntityDescription );
			}
			break;
		case 1:
			// Affected Persistant Stores
		{
			if ( [affectedPersistantStores count] ) {
				// NSEntityDescription *entity = [affectedPersistantStores objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 2:
			// Sort Descriptors
		{
			if ( [orderedSortDescriptors count] ) {
				// NSEntityDescription *entity = [orderedSortDescriptors objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			if ( [keyPathNamesForPrefetching count] ) {
				// NSEntityDescription *entity = [keyPathNamesForPrefetching objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			if ( [propertyDescriptionsToFetch count] ) {
				// NSEntityDescription *entity = [propertyDescriptionsToFetch objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
			
		default:
			break;
	}
}


#pragma mark - Table View Data Source

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
			if ( [affectedPersistantStores count] ) {
				return [affectedPersistantStores count];
			}
		}
			break;
		case 2:
			// Sort Descriptors
		{
			if ( [orderedSortDescriptors count] ) {
				return [orderedSortDescriptors count];
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			if ( [keyPathNamesForPrefetching count] ) {
				return [keyPathNamesForPrefetching count];
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			if ( [propertyDescriptionsToFetch count] ) {
				return [propertyDescriptionsToFetch count];
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
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"FetchListCell";
	static NSString *EmptyIdentifier = @"EmptyListCell";
	
	BOOL presentEmptyCell = NO;
	
	switch (indexPath.section) {
		case 0:
			// Search Entity
			if ( ! fetchEntityDescription ) presentEmptyCell = YES;
			break;
		case 1:
			// Affected Persistant Stores
			if ( ! [affectedPersistantStores count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Sort Descriptors
			if ( ! [orderedSortDescriptors count] ) presentEmptyCell = YES;
			break;
		case 3:
			// Prefetch Keypaths
			if ( ! [keyPathNamesForPrefetching count] ) presentEmptyCell = YES;
			break;
		case 4:
			// Properties to Fetch
			if ( ! [propertyDescriptionsToFetch count] ) presentEmptyCell = YES;
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
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                           reuseIdentifier:CellIdentifier] autorelease];
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
	
	ERS_RELEASE_SAFELY( fetchEntityDescription );
	ERS_RELEASE_SAFELY( affectedPersistantStores );
	ERS_RELEASE_SAFELY( orderedSortDescriptors );
	ERS_RELEASE_SAFELY( keyPathNamesForPrefetching );
	ERS_RELEASE_SAFELY( propertyDescriptionsToFetch );
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailFetchRequest );
	
    [super dealloc];
}


@end

