//
//  PSConfigListController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSConfigListController.h"


@interface PSConfigListController ()
{
    
@private
	NSArray     *_entitiesInConfig;
}

@end


@implementation PSConfigListController


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	NSEntityDescription *entity = _entitiesInConfig[indexPath.row];
	
	cell.textLabel.text = [entity name];
	cell.detailTextLabel.text = [entity managedObjectClassName];
}


#pragma mark - UIViewController

- (void) viewDidLoad 
{
    [super viewDidLoad];
	
	if ( _detailString ) {
		self.title = _detailString;
	}
	
	//self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);

    // Do not preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
	
	_entitiesInConfig = [self.managedObjectModel entitiesForConfiguration:_detailString];
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
	
	// PS_DISMISS_MAIN_POPOVER_IF_NEEDED();
	PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( _entitiesInConfig[indexPath.row] );
	
}


#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
	if ( _entitiesInConfig ) {
		if ( [_entitiesInConfig count] ) {
			return [_entitiesInConfig count];
		}
	}
	
	// When we have no information, we return 1 for an empty cell.
	return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Customize the appearance of table view cells.
    static NSString *CellIdentifier = @"PSConfigListCell";
	static NSString *EmptyIdentifier = @"PSEmptyListCell";
	
	BOOL presentEmptyCell = YES;

	if ( _entitiesInConfig ) {
		if ( [_entitiesInConfig count] ) {
			presentEmptyCell = NO;
		}
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
			//
			return _detailString;
			break;

		default:
			return @"Error";
			break;
	}
}


@end

