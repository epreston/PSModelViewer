//
//  PSDetailViewProtocols.h
//  - Not project specific
//
//  Created by Ed Preston on 7/2/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import <UIKit/UIKit.h>


/**

 Defines the protocol that detail view controllers must adopt.
 
 The protocol specifies methods to hide and show the bar button item controlling the popover.
*/
@protocol PSSwappableDetailView <NSObject>

- (void) showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void) invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;

@end

