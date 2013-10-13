//
//  PSSmallItemUI.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/9/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSSmallItemUI.h"


@interface PSSmallItemUI ()
{
    
@private	
	UILabel			*itemTitle_;
	UILabel			*itemSubTitle_;
	UILabel			*itemType_;
	UITextView		*itemDetails_;
    
	__weak id < PSSmallItemUIDelegate > delegate_;
}
@end


@implementation PSSmallItemUI

@synthesize delegate        = delegate_;
@synthesize itemTitle       = itemTitle_;
@synthesize itemSubTitle    = itemSubTitle_; 
@synthesize itemType        = itemType_;
@synthesize itemDetails     = itemDetails_;


- (IBAction) infoButonAction:(id)sender 
{	
	if (self.delegate) {
		[self.delegate performInfoAction:self];
	}
}


#pragma mark - Initialization

- (void) configureDetaults
{
	// Initialize ivars directly.  As a rule, it's best to avoid invoking accessors from an -init...
	// method, since they may wrongly expect the instance to be fully formed.
}

- (id) initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
		[self configureDetaults];
    }
    return self;
}

- (void) awakeFromNib 
{
	[super awakeFromNib];
    
    [self configureDetaults];
}


#pragma mark - Resource Management

- (void)dealloc
{
    delegate_ = nil;
    
    [super dealloc];
}


@end
