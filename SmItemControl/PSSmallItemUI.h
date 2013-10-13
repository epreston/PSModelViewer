//
//  PSSmallItemUI.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/9/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PSSmallItemUI : UIView

@property(nonatomic, weak) id delegate;

@property(nonatomic, weak) IBOutlet UILabel		*itemTitle;
@property(nonatomic, weak) IBOutlet UILabel		*itemSubTitle;
@property(nonatomic, weak) IBOutlet UILabel		*itemType;
@property(nonatomic, weak) IBOutlet UITextView	*itemDetails;

- (IBAction) infoButonAction:(id)sender;

@end


@protocol PSSmallItemUIDelegate < NSObject >
- (void) performInfoAction: (PSSmallItemUI *) aSmallItem;
@end