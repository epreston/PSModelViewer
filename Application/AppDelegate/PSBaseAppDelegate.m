//
//  PSBaseAppDelegate.m
//  - Not project specific
//
//  Created by Ed Preston on 6/30/10.
//  Copyright Preston Software 2010. All rights reserved.
//

#import "PSBaseAppDelegate.h"
#import "PSContentController.h"


@interface PSBaseAppDelegate ()
{
    
@private
    
    NSManagedObjectModel	*_managedObjectModel;
}

@end


@implementation PSBaseAppDelegate


#pragma mark - Application Lifecycle

- (void) awakeFromNib 
{    
	// Pass the managed object model to the content controller.
    _contentController.managedObjectModel = self.managedObjectModel;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	// Add the content controller's view to the window and display.
    [_window setRootViewController:_contentController.splitViewController];
	[_window addSubview:_contentController.view];
    [_window makeKeyAndVisible];
	
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



#pragma mark - Core Data Stack

- (NSManagedObjectModel *) managedObjectModel 
{    
    // Returns the managed object model for the application.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSLog(@"You can modify the line below to load your data model.");
    
    // Currently configured to load the first "momd" file found. 
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return _managedObjectModel;
}


@end

