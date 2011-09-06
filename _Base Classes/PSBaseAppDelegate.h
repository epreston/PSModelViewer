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
    UIWindow *window;
	PSContentController				*contentController;

@private
    
    NSManagedObjectContext			*managedObjectContext_;
    NSManagedObjectModel			*managedObjectModel_;
    NSPersistentStoreCoordinator	*persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet	UIWindow						*window;
@property (nonatomic, retain) IBOutlet	PSContentController				*contentController;

@property (nonatomic, retain, readonly) NSManagedObjectContext			*managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel			*managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator	*persistentStoreCoordinator;

- (NSString *) applicationDocumentsDirectory;

@end
