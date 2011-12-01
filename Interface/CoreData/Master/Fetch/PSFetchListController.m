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
    NSFetchRequest			*detailFetchRequest_;
	NSEntityDescription		*fetchEntityDescription_;
	NSArray					*affectedPersistantStores_;
	NSArray					*orderedSortDescriptors_;
	NSArray					*keyPathNamesForPrefetching_;
	NSArray					*propertyDescriptionsToFetch_;
}

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
    
@end


@implementation PSFetchListController

@synthesize detailFetchRequest = detailFetchRequest_;


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section) {
		case 0:
			// Search Entity
			cell.textLabel.text = [fetchEntityDescription_ name];
			cell.detailTextLabel.text = [fetchEntityDescription_ managedObjectClassName];
			break;
		case 1:
			// Affected Persistant Stores
		{
			NSPersistentStore *store = [affectedPersistantStores_ objectAtIndex:indexPath.row];
			cell.textLabel.text = [store identifier];
			cell.detailTextLabel.text = [store type];
		}
			break;
		case 2:
			// Sort Descriptors
		{
			NSSortDescriptor *sort = [orderedSortDescriptors_ objectAtIndex:indexPath.row];
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
			cell.textLabel.text = [keyPathNamesForPrefetching_ objectAtIndex:indexPath.row];
			
            NSEntityDescription *entity = [self.managedObjectModel.entitiesByName objectForKey:[keyPathNamesForPrefetching_ objectAtIndex:indexPath.row] ];
            
			if ( entity ) {
				cell.detailTextLabel.text = [entity name];
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			NSPropertyDescription *property = [propertyDescriptionsToFetch_ objectAtIndex:indexPath.row];
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
	
	if ( detailFetchRequest_ ) {
		self.title = @"Fetch Request";
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
	fetchEntityDescription_         = [[detailFetchRequest_ entity] retain];
	affectedPersistantStores_       = [[detailFetchRequest_ affectedStores] retain];
	orderedSortDescriptors_         = [[detailFetchRequest_ sortDescriptors] retain];
	keyPathNamesForPrefetching_     = [[detailFetchRequest_ relationshipKeyPathsForPrefetching] retain];
	propertyDescriptionsToFetch_    = [[detailFetchRequest_ propertiesToFetch] retain];
}


#pragma mark - Resource Management

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
    [detailFetchRequest_ release];
    [fetchEntityDescription_ release];
    [affectedPersistantStores_ release];
    [orderedSortDescriptors_ release];
    [keyPathNamesForPrefetching_ release];
    [propertyDescriptionsToFetch_ release];
    
    [super dealloc];
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
			if ( fetchEntityDescription_ ) {
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( fetchEntityDescription_ );
			}
			break;
		case 1:
			// Affected Persistant Stores
		{
			if ( [affectedPersistantStores_ count] ) {
				// NSEntityDescription *entity = [affectedPersistantStores objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 2:
			// Sort Descriptors
		{
			if ( [orderedSortDescriptors_ count] ) {
				// NSEntityDescription *entity = [orderedSortDescriptors objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			if ( [keyPathNamesForPrefetching_ count] ) {
				// NSEntityDescription *entity = [keyPathNamesForPrefetching objectAtIndex:indexPath.row];
				// PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			if ( [propertyDescriptionsToFetch_ count] ) {
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
			if ( [affectedPersistantStores_ count] ) {
				return [affectedPersistantStores_ count];
			}
		}
			break;
		case 2:
			// Sort Descriptors
		{
			if ( [orderedSortDescriptors_ count] ) {
				return [orderedSortDescriptors_ count];
			}
		}
			break;
		case 3:
			// Prefetch Keypaths
		{
			if ( [keyPathNamesForPrefetching_ count] ) {
				return [keyPathNamesForPrefetching_ count];
			}
		}
			break;
		case 4:
			// Properties to Fetch
		{
			if ( [propertyDescriptionsToFetch_ count] ) {
				return [propertyDescriptionsToFetch_ count];
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
			if ( ! fetchEntityDescription_ ) presentEmptyCell = YES;
			break;
		case 1:
			// Affected Persistant Stores
			if ( ! [affectedPersistantStores_ count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Sort Descriptors
			if ( ! [orderedSortDescriptors_ count] ) presentEmptyCell = YES;
			break;
		case 3:
			// Prefetch Keypaths
			if ( ! [keyPathNamesForPrefetching_ count] ) presentEmptyCell = YES;
			break;
		case 4:
			// Properties to Fetch
			if ( ! [propertyDescriptionsToFetch_ count] ) presentEmptyCell = YES;
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


@end

