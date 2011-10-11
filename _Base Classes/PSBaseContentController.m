//
//  PSBaseContentController.m
//  - Not project specific
//
//  Created by Ed Preston on 7/4/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSBaseContentController.h"


NSString * const PSDetailDisplayRequestNotification = @"PSDetailDisplay";
NSString * const PSMasterDisplayRequestNotification = @"PSMasterDisplay";


@interface PSBaseContentController ()

- (void) masterDisplayRequested:(NSNotification *)notification;
- (void) detailDisplayRequested:(NSNotification *)notification;

@end


@implementation PSBaseContentController

@synthesize managedObjectModel      = managedObjectModel_;

@synthesize splitViewController     = splitViewController_;
@synthesize navigationController    = navigationController_;

@synthesize rootViewController      = rootViewController_;
@synthesize detailViewController    = detailViewController_;

#pragma mark - Display Contoller Lookup

- (UIViewController *) newMasterControllerFor:(NSNotification *)notification 
{	
	// IMPLEMENT IN SUBCLASS
	return nil;
}

- (UIViewController *) newDetailControllerFor:(NSNotification *)notification 
{	
	// IMPLEMENT IN SUBCLASS
	return nil;
}


#pragma mark - Primary View For Application

- (UIView *) view 
{	
	// Add logic here to switch between application types
    return self.splitViewController.view;
}


#pragma mark - Object LifeCycle

- (void) awakeFromNib 
{	
	// Call super
	[super awakeFromNib];
    
    [self passManagedObjectModel:managedObjectModel_ toObject:rootViewController_];
    [self passManagedObjectModel:managedObjectModel_ toObject:detailViewController_];
	
	// Listen for our messages
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	
	[dnc addObserver:self 
			selector:@selector(masterDisplayRequested:) 
				name:PSMasterDisplayRequestNotification 
			  object:nil];
	
	[dnc addObserver:self 
			selector:@selector(detailDisplayRequested:) 
				name:PSDetailDisplayRequestNotification 
			  object:nil];
	
}

- (void) dealloc 
{	
	// Remove self as an observer.
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    [managedObjectModel_ release];
    
	[rootViewController_ release];
    [detailViewController_ release];
	[navigationController_ release];
	[splitViewController_ release];
	
    [super dealloc];
}


#pragma mark - Application Notifications

- (void) masterDisplayRequested:(NSNotification *)notification 
{	
	// Open the notification, pull out the object
	NSObject *notificationObject		= [notification object];
	
	// Request the correct view controller
	UIViewController *newViewController =  [ self newMasterControllerFor:notificationObject ];
	
	if ( newViewController ) {
		
		[navigationController_ pushViewController:newViewController animated:YES];
		
        [newViewController release];
	} else {
		
		// No controller returned, pop all
		[navigationController_ popToRootViewControllerAnimated:YES];
	}
}

- (void) detailDisplayRequested:(NSNotification *)notification 
{	
	// Open the notification, pull out the object
	NSObject *notificationObject		= [notification object];
	
    // Request the correct view controller
	UIViewController *newViewController =  [ self newDetailControllerFor:notificationObject ];
	
	if ( newViewController ) {
				
		// Update the split view controller's view controllers array.
		NSArray *viewControllers = [[NSArray alloc] initWithObjects:navigationController_, newViewController, nil];
		splitViewController_.viewControllers = viewControllers;
		[viewControllers release];
		
        // Release the viewController that was returned.
        [newViewController release];
        
    } else {
        
        // Update the split view controller's view controllers array. Pop back to default detail display.
		NSArray *viewControllers = [[NSArray alloc] initWithObjects:navigationController_, [self detailViewController], nil];
		splitViewController_.viewControllers = viewControllers;
		[viewControllers release];
    }
    
    // Ensure button for popup is visable if needed
    [[NSNotificationCenter defaultCenter] postNotificationName:PSConfirmPopoverRequestNotification object:nil];
}


#pragma mark - Support Code For Passing Objects to Controllers

- (void) passManagedObjectContext:(NSManagedObjectContext *)objectContext 
                        toObject:(NSObject <PSAcceptsManagedObjectContext> *)targetObject 
{	
	NSObject <PSAcceptsManagedObjectContext> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsManagedObjectContext)]  ) {
		dest.managedObjectContext	= objectContext;
	}
}

- (void) passManagedObjectModel:(NSManagedObjectModel *)objectModel 
                      toObject:(NSObject <PSAcceptsManagedObjectModel> *)targetObject 
{	
	NSObject <PSAcceptsManagedObjectModel> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsManagedObjectModel)]  ) {
		dest.managedObjectModel	= objectModel;
	}
}

- (void) passEntityDescription:(NSEntityDescription *)entityDescription 
                     toObject:(NSObject <PSAcceptsEntityDescription> *)targetObject 
{	
	NSObject <PSAcceptsEntityDescription> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsEntityDescription)]  ) {
		dest.detailEntityDescription = entityDescription;
	}
}

- (void) passFetchRequest:(NSFetchRequest *)fetchRequest 
                toObject:(NSObject <PSAcceptsFetchRequest> *)targetObject 
{	
	NSObject <PSAcceptsFetchRequest> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsFetchRequest)]  ) {
		dest.detailFetchRequest = fetchRequest;
	}
}

- (void) passAttributeDescription:(NSAttributeDescription *)attributeDescription 
                        toObject:(NSObject <PSAcceptsAttributeDescription> *)targetObject 
{	
	NSObject <PSAcceptsAttributeDescription> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsAttributeDescription)]  ) {
		dest.detailAttributeDescription = attributeDescription;
	}
}

- (void) passRelationshipDescription:(NSRelationshipDescription *)relationshipDescription 
                           toObject:(NSObject <PSAcceptsRelationshipDescription> *)targetObject 
{	
	NSObject <PSAcceptsRelationshipDescription> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsRelationshipDescription)]  ) {
		dest.detailRelationshipDescription = relationshipDescription;
	}
}

- (void) passFetchedPropertyDescription:(NSFetchedPropertyDescription *)fetchedPropertyDescription 
                              toObject:(NSObject <PSAcceptsFetchedPropertyDescription> *)targetObject 
{	
	NSObject <PSAcceptsFetchedPropertyDescription> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsFetchedPropertyDescription)]  ) {
		dest.detailFetchedPropertyDescription = fetchedPropertyDescription;
	}
}

- (void) passManagedObject:(NSManagedObject *)managedObject 
                 toObject:(NSObject <PSAcceptsManagedObjects> *)targetObject 
{	
	NSObject <PSAcceptsManagedObjects> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsManagedObjects)]  ) {
		dest.detailObject = managedObject;
	}
}

- (void) passSet:(NSSet *)aSet 
       toObject:(NSObject <PSAcceptsSets> *)targetObject 
{	
	NSObject <PSAcceptsSets> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsSets)]  ) {
		dest.detailSet = aSet;
	}
}

- (void) passString:(NSString *)aString 
          toObject:(NSObject <PSAcceptsString> *)targetObject 
{
	NSObject <PSAcceptsString> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsString)]  ) {
		dest.detailString = aString;
	}
}


- (void) passArray:(NSArray *)anArray 
         toObject:(NSObject <PSAcceptsArray> *)targetObject 
{	
	NSObject <PSAcceptsArray> *dest = targetObject;
	
	// Set the item to present
	if (  [dest conformsToProtocol:@protocol(PSAcceptsArray)]  ) {
		dest.detailArray = anArray;
	}
}

//- (void) passObject:(NSObject *)anObject toObject:(NSObject *) targetObject {
//	
//}


@end
