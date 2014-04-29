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
	NSEntityDescription		*_superEntityDescription;
	NSArray					*_subEntityDescriptions;
	NSArray					*_atrributesOfEntity;
	NSArray					*_relationshipsOfEntity;
	NSMutableArray			*_fetchedPropertiesOfEntity;
}

@end


@implementation PSEntityListController

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	switch (indexPath.section ) {
		case 0:
			// Super Entity
			cell.textLabel.text = [_superEntityDescription name];
			cell.detailTextLabel.text = [_superEntityDescription managedObjectClassName];
			break;
		case 1:
			// Sub Entities
		{
			NSEntityDescription *entity = _subEntityDescriptions[indexPath.row];
			cell.textLabel.text = [entity name];
			cell.detailTextLabel.text = [entity managedObjectClassName];
		}
			break;
		case 2:
			// Attributes
		{
			NSAttributeDescription *attrib = _atrributesOfEntity[indexPath.row];
			cell.textLabel.text = [attrib name];
			cell.detailTextLabel.text = [attrib attributeValueClassName];
		}
			break;
		case 3:
			// Relationships
		{
			NSRelationshipDescription *relation = _relationshipsOfEntity[indexPath.row];
			cell.textLabel.text = [relation name];
			cell.detailTextLabel.text = [[relation destinationEntity] name];
		}	
			break;
		case 4:
			// Fetched Properties
		{
			NSFetchedPropertyDescription *fetches = _fetchedPropertiesOfEntity[indexPath.row];
			cell.textLabel.text = [fetches name];
			cell.detailTextLabel.text = @"value is dynamic";
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
	
	if ( _detailEntityDescription ) {
		self.title = [_detailEntityDescription name];
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
	_superEntityDescription     = [_detailEntityDescription superentity];
	_subEntityDescriptions      = [_detailEntityDescription subentities];
	_atrributesOfEntity         = [[_detailEntityDescription attributesByName] allValues];
	_relationshipsOfEntity      = [[_detailEntityDescription relationshipsByName] allValues];
	
	// I am not happy we do not have direct access to fetched properties
	NSArray *allProperties = [_detailEntityDescription properties];
	
	_fetchedPropertiesOfEntity  = [NSMutableArray arrayWithCapacity:6];
	
	for ( NSPropertyDescription *aProperty in allProperties ) {
		if ( [aProperty isKindOfClass:[NSFetchedPropertyDescription class]] ) {
			// add item to fetchedPropertiesOfEntity
			[_fetchedPropertiesOfEntity addObject:aProperty];
		}
	}
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
	//
	
	switch (indexPath.section ) {
		case 0:
			// Super Entity
			if ( _superEntityDescription ) {
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( _superEntityDescription );
			}
			break;
		case 1:
			// Sub Entities
		{
			if ( [_subEntityDescriptions count] ) {
				NSEntityDescription *entity = _subEntityDescriptions[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entity );
			}
		}
			break;
		case 2:
			// Attributes
		{
			if ( [_atrributesOfEntity count] ) {
				NSAttributeDescription *attrib = _atrributesOfEntity[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( attrib );
			}
		}
			break;
		case 3:
			// Relationships
		{
			if ( [_relationshipsOfEntity count] ) {
				NSRelationshipDescription *relation = _relationshipsOfEntity[indexPath.row];
				PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( relation );
			}
		}
			break;
		case 4:
			// Fetched Properties
		{
			if ( [_fetchedPropertiesOfEntity count] ) {
				NSFetchedPropertyDescription *fetches = _fetchedPropertiesOfEntity[indexPath.row];
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
			if ( [_subEntityDescriptions count] ) {
				return [_subEntityDescriptions count];
			}
		}
			break;
		case 2:
			// Attributes
		{
			if ( [_atrributesOfEntity count] ) {
				return [_atrributesOfEntity count];
			}
		}
			break;
		case 3:
			// Relationships
		{
			if ( [_relationshipsOfEntity count] ) {
				return [_relationshipsOfEntity count];
			}
		}
			break;
		case 4:
			// Fetched Properties
		{
			if ( [_fetchedPropertiesOfEntity count] ) {
				return [_fetchedPropertiesOfEntity count];
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
			if ( ! _superEntityDescription ) presentEmptyCell = YES;
			break;
		case 1:
			// Sub Entities
			if ( ! [_subEntityDescriptions count] ) presentEmptyCell = YES;
			break;
		case 2:
			// Attributes
			if ( ! [_atrributesOfEntity count] ) presentEmptyCell = YES;
			break;
		case 3:
			// Relationships
			if ( ! [_relationshipsOfEntity count ] ) presentEmptyCell = YES;
			break;
		case 4:
			// Fetched Properties
			if ( ! [_fetchedPropertiesOfEntity count] ) presentEmptyCell = YES;
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

