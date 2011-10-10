//
//  PSSmallItemUI.h
//  GridTest
//
//  Created by Ed Preston on 7/9/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>


@class PSSmallItemUI;


@protocol PSSmallItemUIDelegate < NSObject >

- (void) performInfoAction: (PSSmallItemUI *) aSmallItem;

@end


@interface PSSmallItemUI : UIViewController 
{
    
@private	
	UILabel			*itemTitle_;
	UILabel			*itemSubTitle_;
	UILabel			*itemType_;
	UITextView		*itemDetails_;
    
	id < PSSmallItemUIDelegate > delegate_;
}

@property(nonatomic, assign) id delegate;

@property(nonatomic, retain) IBOutlet UILabel		*itemTitle;
@property(nonatomic, retain) IBOutlet UILabel		*itemSubTitle;
@property(nonatomic, retain) IBOutlet UILabel		*itemType;
@property(nonatomic, retain) IBOutlet UITextView	*itemDetails;

- (IBAction) infoButonAction:(id)sender;

@end
