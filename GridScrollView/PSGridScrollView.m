//
//  PSGridScrollView.m
//
//  Created by Ed Preston on 7/8/10.
//  Copyright Preston Software 2010. All rights reserved.
//
//  Attempts to show the maximum number of items per row, creates spacing between the items
//  to fill the scrollview width evenly.
//


#import "PSGridScrollView.h"


// We will be scrolling at possibly mixing and matching views.  This controls if they are marked
// opaque automaticly to increase performance.  Turn off if rendering artifacts occur as seen in the
// buttons with rounded corners.

#define OPAQUE_ITEM_VIEWS 1


@implementation PSGridScrollView


#pragma mark - Properties

@synthesize itemWidth = _itemWidth;

- (void)setItemWidth:(int)newValue 
{	
	_itemWidth = newValue;
	
	// Update the display
	[self setNeedsLayout];
}

@synthesize	itemHeight = _itemHeight;

- (void) setItemHeight:(int)newValue 
{	
	_itemHeight = newValue;
	
	// Update the display
	[self setNeedsLayout];
}

@synthesize itemBorder = _itemBorder;

- (void) setItemBorder:(int)newValue 
{	
	_itemBorder = newValue;
	
	// Update the display
	[self setNeedsLayout];
}

- (NSMutableArray *) gridViews 
{	
	// lazy creation
	if ( _gridViews != nil) {
		return _gridViews;
	}
	
	_gridViews = [[NSMutableArray alloc] init];
	
	return _gridViews;
}

- (void) setGridViews:(NSMutableArray *)array
{
	if (_gridViews != array)
    {
		
		// Remove the old views
		for (UIView *view in _gridViews)
			[view removeFromSuperview];
		[_gridViews release];
		
		if ( array != nil ) {
			
			// Copy the array
			_gridViews = [array retain];
			
			// Add the new views
			for (UIView *view in _gridViews)
				[self addSubview:view];
			
		} else {
			_gridViews = nil;
		}
		
		// Update the display
		[self setNeedsLayout];
    }
}


#pragma mark - Methods

- (void) addViewToGrid:(UIView *)view {
	
	// Save the view for later
	[self.gridViews addObject:view];
	
	// Add it to the scrollview
	[self addSubview:view];
	
	// Update the display
	[self setNeedsLayout];
	
}


#pragma mark - View Display 

- (void) layoutSubviews {

	// We do not need to layout the grid on scrolling
	if (self.dragging == NO && self.decelerating == NO) {
		// NSLog(@"Layout Requested.");
		
		// Sanity checks
		if (_itemWidth < 40) _itemWidth = 40;
		if (_itemHeight < 40) _itemHeight = 40;
		if (_itemBorder < 0) _itemBorder = 0;
		
		// Caluculate the item width and height with a border on both sides
		int widthWithBorder = _itemWidth + (_itemBorder * 2);
		int heightWithBorder = _itemHeight + (_itemBorder * 2);
		
		// calculate the number of columns that can fit
		CGRect bounds = [self bounds];
		int cols = bounds.size.width / widthWithBorder;
		
		// Caluculate the spacing to make it use up the margin
		int itemSpacing = (bounds.size.width - (widthWithBorder * cols)) / (cols + 1);
		
		// Used to caluculate the origin for the each view
		int xOrigin = 0;
		int yOrigin = 0;
		
		for ( UIView *view in self.gridViews ) {
			
			// find the new index of the item to draw
			int index = [self.gridViews indexOfObject:view];
			
			// calculate out index in the grid
			int y = index / cols;
			int x = index - y * cols;
		
			// calculate the origion for the current view
			xOrigin = (x * widthWithBorder) + (x * itemSpacing) + itemSpacing + _itemBorder;
			yOrigin = (y * heightWithBorder) + (y * itemSpacing) + itemSpacing + _itemBorder;
			
			// update its frame
			view.frame = CGRectMake(xOrigin, yOrigin, _itemWidth, _itemHeight);
			
			// Set the item to opaque
			view.opaque = OPAQUE_ITEM_VIEWS ? YES : NO;
			
		}
	
		// We may have changed orientation or size.
		[self setContentSize:CGSizeMake (bounds.size.width, yOrigin + _itemHeight + itemSpacing + _itemBorder)];
	}
}


#pragma mark - Resource Management

- (void) dealloc 
{	
	[_gridViews release];
	
	[super dealloc];
}


@end