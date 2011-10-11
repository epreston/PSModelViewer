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

@interface PSBaseAppDelegate : NSObject 
    < UIApplicationDelegate > 
{    

@protected
    
    UIWindow                *window_;
	PSContentController     *contentController_;
    
@private

    NSManagedObjectModel	*managedObjectModel_;
}

@property (nonatomic, retain) IBOutlet	UIWindow				*window;
@property (nonatomic, retain) IBOutlet	PSContentController     *contentController;

@property (nonatomic, readonly, retain) NSManagedObjectModel	*managedObjectModel;

@end
