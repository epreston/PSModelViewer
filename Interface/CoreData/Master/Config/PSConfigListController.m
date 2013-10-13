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
    NSString	*detailString_;
	NSArray     *entitiesInConfig_;
}

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation PSConfigListController

@synthesize detailString = detailString_;


- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{    
	NSEntityDescription *entity = entitiesInConfig_[indexPath.row];
	
	cell.textLabel.text = [entity name];
	cell.detailTextLabel.text = [entity managedObjectClassName];
}


#pragma mark - View lifecycle

- (void) viewDidLoad 
{
    [super viewDidLoad];
	
	if ( detailString_ ) {
		self.title = detailString_;
	}
	
	//self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);

    // Do not preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
	
	entitiesInConfig_ = [self.managedObjectModel entitiesForConfiguration:detailString_];
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
	PS_SHOW_DETAIL_DISPLAY_FOR_OBJECT( entitiesInConfig_[indexPath.row] );
	
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
	if ( entitiesInConfig_ ) {
		if ( [entitiesInConfig_ count] ) {
			return [entitiesInConfig_ count];
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

	if ( entitiesInConfig_ ) {
		if ( [entitiesInConfig_ count] ) {
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
			return detailString_;
			break;

		default:
			return @"Error";
			break;
	}
}


@end

