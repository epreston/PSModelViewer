//
//  PSEntityListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSEntityListController.h"


@interface PSEntityListController ()
{
    
@private
    NSEntityDescription		*detailEntityDescription_;
	NSEntityDescription		*superEntityDescription_;
	NSArray					*subEntityDescriptions_;
	NSArray					*atrributesOfEntity_;
	NSArray					*relationshipsOfEntity_;
	NSMutableArray			*fetchedPropertiesOfEntity_;
}

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation PSEntityListController

@synthesize detailEntityDescription = detailEntityDescription_;


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section ) {
		case 0:
			// Super Entity
			cell.textLabel.text = [superEntityDescription_ name];
			cell.detailTextLabel.text = [superEntityDescription_ managedObjectClassName];
			break;
		case 1:
			// Sub Entities
		{
			NSEntityDescription *entity = subEntityDescriptions_[indexPath.row];
			cell.textLabel.text = [entity name];
			cell.detailTextLabel.text = [entity managedObjectClassName];
		}
			break;
		case 2:
			// Attributes
		{
			NSAttributeDescription *attrib = atrributesOfEntity_[indexPath.row];
			cell.textLabel.text = [attrib name];
			cell.detailTextLabel.text = [attrib attributeValueClassName];
		}
			break;
		case 3:
			// Relationships
		{
			NSRelationshipDescription *relation = relationshipsOfEntity_[indexPath.row];
			cell.textLabel.text = [relation name];
			cell.detailTextLabel.text = [[relation destinationEntity] name];
		}	
			break;
		case 4:
			// Fetched Properties
		{
			NSFetchedPropertyDescription *fetches = fetchedPropertiesOfEntity_[indexPath.row];
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
	
	if ( detailEntityDescription_ ) {
		self.title = [detailEntityDescription_ name];
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
	superEntityDescription_     = [[detailEntityDescription_ superentity] retain];
	subEntityDescriptions_      = [[detailEntityDescription_ subentities] retain];
	atrributesOfEntity_         = [[[detailEntityDescription_ attributesByName] allValues] retain];
	relationshipsOfEntity_      = [[[detailEntityDescription_ relationshipsByName] allValues] retain];
	
	// I am not happy we do not have direct access to fetched properties
	NSArray *allProperties = [detailEntityDescription_ properties];
	
	fetchedPropertiesOfEntity_  = [[NSMutableArray arrayWithCapacity:6] retain];
	
	for ( NSPropertyDescription *aProperty in allProperties ) {
		if ( [aProperty isKindOfClass:[NSFetchedPropertyDescription class]] ) {
			// add item to fetchedPropertiesOfEntity
			[fetchedPropertiesOfEntity_ addObject:aProperty];
		}
	}
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
    [detailEntityDescription_ release];
    [superEntityDescription_ release];
    [subEntityDescriptions_ release];
    [atrributesOfEntity_ release];
    [relationshipsOfEntity_ release];
    [fetchedPropertiesOfEntity_ release];
    
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
	//
	
	switch (indexPath.section ) {
		case 0:
			// Super Entity
			if ( superEntityDescription_ ) {
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( superEntityDescription_ );
			}
			break;
		case 1:
			// Sub Entities
		{
			if ( [subEntityDescriptions_ count] ) {
				NSEntityDescription *entity = subEntityDescriptions_[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 2:
			// Attributes
		{
			if ( [atrributesOfEntity_ count] ) {
				NSAttributeDescription *attrib = atrributesOfEntity_[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( attrib );
			}
		}
			break;
		case 3:
			// Relationships
		{
			if ( [relationshipsOfEntity_ count] ) {
				NSRelationshipDescription *relation = relationshipsOfEntity_[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( relation );
			}
		}
			break;
		case 4:
			// Fetched Properties
		{
			if ( [fetchedPropertiesOfEntity_ count] ) {
				NSFetchedPropertyDescription *fetches = fetchedPropertiesOfEntity_[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( fetches );
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
			// Super Entity or place for message
			return 1;
			break;
		case 1:
			// Sub Entities
		{
			if ( [subEntityDescriptions_ count] ) {
				return [subEntityDescriptions_ count];
			}
		}
			break;
		case 2:
			// Attributes
		{
			if ( [atrributesOfEntity_ count] ) {
				return [atrributesOfEntity_ count];
			}
		}
			break;
		case 3:
			// Relationships
		{
			if ( [relationshipsOfEntity_ count] ) {
				return [relationshipsOfEntity_ count];
			}
		}
			break;
		case 4:
			// Fetched Properties
		{
			if ( [fetchedPropertiesOfEntity_ count] ) {
				return [fetchedPropertiesOfEntity_ count];
			}
		}
			break;
			
		default:
			break;
	}
	
	// When we have no information, we return 1 for an empty cell.
	return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView 
          cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Customize the appearance of table view cells.
    static NSString *CellIdentifier = @"PSEntityListCell";
	static NSString *EmptyIdentifier = @"PSEmptyListCell";
	
	BOOL presentEmptyCell = NO;
    
	switch (indexPath.section) {
		case 0:
			// Super Entity
			if ( ! superEntityDescription_ ) presentEmptyCell = YES;
			break;
		case 1:
			// Sub Entities
			if ( ! [subEntityDescriptions_ count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Attributes
			if ( ! [atrributesOfEntity_ count] ) presentEmptyCell = YES;
			break;
		case 3:
			// Relationships
			if ( ! [relationshipsOfEntity_ count ] ) presentEmptyCell = YES;
			break;
		case 4:
			// Fetched Properties
			if ( ! [fetchedPropertiesOfEntity_ count] ) presentEmptyCell = YES;
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


@end

