//
//  PSEntityListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSEntityListController.h"


@implementation PSEntityListController

@synthesize detailEntityDescription;

@synthesize superEntityDescription, subEntityDescriptions;
@synthesize atrributesOfEntity, relationshipsOfEntity, fetchedPropertiesOfEntity;


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section ) {
		case 0:
			// Super Entity
			cell.textLabel.text = [superEntityDescription name];
			cell.detailTextLabel.text = [superEntityDescription managedObjectClassName];
			break;
		case 1:
			// Sub Entities
		{
			NSEntityDescription *entity = [subEntityDescriptions objectAtIndex:indexPath.row];
			cell.textLabel.text = [entity name];
			cell.detailTextLabel.text = [entity managedObjectClassName];
		}
			break;
		case 2:
			// Attributes
		{
			NSAttributeDescription *attrib = [atrributesOfEntity objectAtIndex:indexPath.row];
			cell.textLabel.text = [attrib name];
			cell.detailTextLabel.text = [attrib attributeValueClassName];
		}
			break;
		case 3:
			// Relationships
		{
			NSRelationshipDescription *relation = [relationshipsOfEntity objectAtIndex:indexPath.row];
			cell.textLabel.text = [relation name];
			cell.detailTextLabel.text = [[relation destinationEntity] name];
		}	
			break;
		case 4:
			// Fetched Properties
		{
			NSFetchedPropertyDescription *fetches = [fetchedPropertiesOfEntity objectAtIndex:indexPath.row];
			cell.textLabel.text = [fetches name];
			cell.detailTextLabel.text = @"value is dynamic";
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
	
	if ( detailEntityDescription ) {
		self.title = [detailEntityDescription name];
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	superEntityDescription = [detailEntityDescription superentity];
	subEntityDescriptions = [[detailEntityDescription subentities] retain];
	
	atrributesOfEntity = [[[detailEntityDescription attributesByName] allValues] retain];
	relationshipsOfEntity = [[[detailEntityDescription relationshipsByName] allValues] retain];
	
	// I am not happy we do not have direct access to fetched properties
	NSArray *allProperties = [detailEntityDescription properties];
	
	fetchedPropertiesOfEntity = [[NSMutableArray arrayWithCapacity:6] retain];
	
	for ( NSPropertyDescription *aProperty in allProperties ) {
		if ( [aProperty isKindOfClass:[NSFetchedPropertyDescription class]] ) {
			// add item to fetchedPropertiesOfEntity
			[fetchedPropertiesOfEntity addObject:aProperty];
		}
	}
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
	
	switch (indexPath.section ) {
		case 0:
			// Super Entity
			if ( superEntityDescription ) {
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( superEntityDescription );
			}
			break;
		case 1:
			// Sub Entities
		{
			if ( [subEntityDescriptions count] ) {
				NSEntityDescription *entity = [subEntityDescriptions objectAtIndex:indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 2:
			// Attributes
		{
			if ( [atrributesOfEntity count] ) {
				NSAttributeDescription *attrib = [atrributesOfEntity objectAtIndex:indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( attrib );
			}
		}
			break;
		case 3:
			// Relationships
		{
			if ( [relationshipsOfEntity count] ) {
				NSRelationshipDescription *relation = [relationshipsOfEntity objectAtIndex:indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( relation );
			}
		}
			break;
		case 4:
			// Fetched Properties
		{
			if ( [fetchedPropertiesOfEntity count] ) {
				NSFetchedPropertyDescription *fetches = [fetchedPropertiesOfEntity objectAtIndex:indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( fetches );
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
			// Super Entity or place for message
			return 1;
			break;
		case 1:
			// Sub Entities
		{
			if ( [subEntityDescriptions count] ) {
				return [subEntityDescriptions count];
			}
		}
			break;
		case 2:
			// Attributes
		{
			if ( [atrributesOfEntity count] ) {
				return [atrributesOfEntity count];
			}
		}
			break;
		case 3:
			// Relationships
		{
			if ( [relationshipsOfEntity count] ) {
				return [relationshipsOfEntity count];
			}
		}
			break;
		case 4:
			// Fetched Properties
		{
			if ( [fetchedPropertiesOfEntity count] ) {
				return [fetchedPropertiesOfEntity count];
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
- (UITableViewCell *) tableView:(UITableView *)tableView 
          cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"EntityListCell";
	static NSString *EmptyIdentifier = @"EmptyListCell";
	
	BOOL presentEmptyCell = NO;
    
	switch (indexPath.section) {
		case 0:
			// Super Entity
			if ( ! superEntityDescription ) presentEmptyCell = YES;
			break;
		case 1:
			// Sub Entities
			if ( ! [subEntityDescriptions count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Attributes
			if ( ! [atrributesOfEntity count] ) presentEmptyCell = YES;
			break;
		case 3:
			// Relationships
			if ( ! [relationshipsOfEntity count ] ) presentEmptyCell = YES;
			break;
		case 4:
			// Fetched Properties
			if ( ! [fetchedPropertiesOfEntity count] ) presentEmptyCell = YES;
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
			// Super Entity
			return @"Super Entity";
			break;
		case 1:
			// Sub Entities
			return @"Sub Entities";
			break;
		case 2:
			// Attributes
			return @"Attributes";
			break;
		case 3:
			// Relationships
			return @"Relationships";
			break;
		case 4:
			// Fetched Properties
			return @"Fetched Properties";
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
	
	ERS_RELEASE_SAFELY( superEntityDescription );
	ERS_RELEASE_SAFELY(	subEntityDescriptions );
	ERS_RELEASE_SAFELY(	atrributesOfEntity );
	ERS_RELEASE_SAFELY(	relationshipsOfEntity );
	ERS_RELEASE_SAFELY(	fetchedPropertiesOfEntity );
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailEntityDescription );
	
    [super dealloc];
}


@end

