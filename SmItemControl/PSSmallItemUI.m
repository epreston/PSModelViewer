//
//  PSSmallItemUI.m
//  GridTest
//
//  Created by Ed Preston on 7/9/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSSmallItemUI.h"


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


#pragma mark - Rotation Support

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


#pragma mark - Resource Management

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{    
	[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) dealloc 
{    
	[super dealloc];
}


@end
