//
//  PSBaseAppDelegate.m
//  - Not project specific
//
//  Created by Ed Preston on 6/30/10.
//  Copyright Preston Software 2010. All rights reserved.
//


#import "PSBaseAppDelegate.h"
#import "PSContentController.h"


@implementation PSBaseAppDelegate

@synthesize window              = window_;
@synthesize contentController   = contentController_;


#pragma mark - Application Lifecycle

- (void) awakeFromNib 
{    
	// Pass the managed object context to the content controller.
    contentController_.managedObjectContext = self.managedObjectContext; 
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	
	// Add the split view controller's view to the window and display.
	[window_ addSubview:contentController_.view];
    [window_ makeKeyAndVisible];
	
	return YES;
}


#pragma mark - Resource Management

- (void) applicationDidReceiveMemoryWarning:(UIApplication *)application 
{    
	/*
     Free up as much memory as possible by purging cached data objects that can be 
     recreated (or reloaded from disk) later.
     */
}

- (void) dealloc
{
    [contentController_ release];
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    [window_ release];
    
    [super dealloc];
}


#pragma mark - Core Data Stack

/**
 Returns the managed object context for the application.
 
 If the context doesn't already exist, it is created and bound to the persistent 
 store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext 
{    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

/**
 Returns the managed object model for the application.
 
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *) managedObjectModel 
{    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"ModelViewer" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}

/**
 Returns the persistent store coordinator for the application.
 
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator 
{    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
// TODO: Replace the file name below or create a generic solution for this.    
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"ModelViewer.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType 
                                                   configuration:nil 
                                                             URL:storeURL 
                                                         options:nil 
                                                           error:&error]) {
        
		/*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this
		 function in a shipping application, although it may be useful during development. If it is not
		 possible to recover from the error, display an alert panel that instructs the user to quit the
		 application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path.
		 Often, a file URL is pointing into the application's resources directory instead of a writeable 
		 directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary
         as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; 
		 consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
		
        
		ERS_DEBUG_STORE_ERROR(error);
		
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark - Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *) applicationDocumentsDirectory 
{    
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end

