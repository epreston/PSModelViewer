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
    
@protected
    
    UIWindow                *window_;
	PSContentController     *contentController_;
    
@private
    
    NSManagedObjectModel	*managedObjectModel_;
}

@end



@implementation PSBaseAppDelegate

@synthesize window              = window_;
@synthesize contentController   = contentController_;


#pragma mark - Application Lifecycle

- (void) awakeFromNib 
{    
	// Pass the managed object model to the content controller.
    contentController_.managedObjectModel = self.managedObjectModel;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	// Add the content controller's view to the window and display.
    [window_ setRootViewController:contentController_.splitViewController];
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



#pragma mark - Core Data Stack

- (NSManagedObjectModel *) managedObjectModel 
{    
    // Returns the managed object model for the application.
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    
    NSLog(@"You can modify the line below to load your data model.");
    
    // Currently configured to load the first "momd" file found. 
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


@end

