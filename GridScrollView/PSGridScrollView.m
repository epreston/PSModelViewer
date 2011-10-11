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

@synthesize itemWidth = itemWidth_;

- (void) setItemWidth:(int)newValue 
{	
    itemWidth_ = (newValue < 40) ? 40 : newValue;
	
	// Update the display
	[self setNeedsLayout];
}

@synthesize	itemHeight = itemHeight_;

- (void) setItemHeight:(int)newValue 
{	
	itemHeight_ = (newValue < 40) ? 40 : newValue;
	
	// Update the display
	[self setNeedsLayout];
}

@synthesize itemBorder = itemBorder_;

- (void) setItemBorder:(int)newValue 
{	
	itemBorder_ = (newValue < 0) ? 0 : newValue;
	
	// Update the display
	[self setNeedsLayout];
}

- (NSMutableArray *) gridViews 
{	
	// lazy creation
	if ( gridViews_ != nil) {
		return gridViews_;
	}
	
	gridViews_ = [[NSMutableArray alloc] init];
	
	return gridViews_;
}

- (void) setGridViews:(NSMutableArray *)array
{
	if (gridViews_ != array)
    {
		// Remove the old views
		for (UIView *view in gridViews_)
			[view removeFromSuperview];
		[gridViews_ release];
		
		if ( array != nil ) {
			
			// Copy the array
			gridViews_ = [array retain];
			
			// Add the new views
			for (UIView *view in gridViews_)
				[self addSubview:view];
			
		} else {
			gridViews_ = nil;
		}
		
		// Update the display
		[self setNeedsLayout];
    }
}


#pragma mark - Resource Management

- (void) dealloc 
{	
	[gridViews_ release];
	
	[super dealloc];
}


#pragma mark - Methods

- (void) addViewToGrid:(UIView *)view {
    
    // See setGridViews to add items in bulk.
	
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
		if (itemWidth_ < 40)   itemWidth_   = 40;
		if (itemHeight_ < 40)  itemHeight_  = 40;
		if (itemBorder_ < 0)   itemBorder_  = 0;
		
		// Caluculate the item width and height with a border on both sides
		int widthWithBorder = itemWidth_ + (itemBorder_ * 2);
		int heightWithBorder = itemHeight_ + (itemBorder_ * 2);
		
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
			xOrigin = (x * widthWithBorder) + (x * itemSpacing) + itemSpacing + itemBorder_;
			yOrigin = (y * heightWithBorder) + (y * itemSpacing) + itemSpacing + itemBorder_;
			
			// update its frame
			view.frame = CGRectMake(xOrigin, yOrigin, itemWidth_, itemHeight_);
			
			// Set the item to opaque
			view.opaque = OPAQUE_ITEM_VIEWS ? YES : NO;
			
		}
	
		// We may have changed orientation or size.
		[self setContentSize:CGSizeMake (bounds.size.width, yOrigin + itemHeight_ + itemSpacing + itemBorder_)];
	}
}


@end