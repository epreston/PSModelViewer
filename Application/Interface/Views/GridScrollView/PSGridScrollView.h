//
//  PSGridScrollView.h
//
//  Created by Ed Preston on 7/8/10.
//  Copyright Preston Software 2010. All rights reserved.
//
//  Attempts to show the maximum number of items per row, creates spacing between 
//  the items to fill the scrollview widtch evenly.
//

#import <UIKit/UIKit.h>


@interface PSGridScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray *gridViews;
@property (nonatomic, assign) int	itemWidth;
@property (nonatomic, assign) int	itemHeight;
@property (nonatomic, assign) int	itemBorder;

- (void) addViewToGrid:(UIView *)view;

@end
