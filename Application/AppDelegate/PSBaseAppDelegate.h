//
//  PSBaseAppDelegate.h
//  - Not project specific
//
//  Created by Ed Preston on 6/30/10.
//  Copyright Preston Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class PSContentController;

@interface PSBaseAppDelegate : UIResponder < UIApplicationDelegate >

@property (nonatomic, strong) IBOutlet	UIWindow				*window;
@property (nonatomic, strong) IBOutlet	PSContentController     *contentController;
@property (nonatomic, readonly, strong) NSManagedObjectModel	*managedObjectModel;

@end
