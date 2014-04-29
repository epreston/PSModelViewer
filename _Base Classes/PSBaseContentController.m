//
//  PSBaseContentController.m
//  - Not project specific
//
//  Created by Ed Preston on 7/4/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSBaseContentController.h"
#import "PSDetailViewProtocols.h"
#import "PSCoreDataProtocols.h"


NSString * const PSDetailDisplayRequestNotification = @"PSDetailDisplay";
NSString * const PSMasterDisplayRequestNotification = @"PSMasterDisplay";


@implementation PSBaseContentController


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
    
    [self passManagedObjectModel:_managedObjectModel toObject:_rootViewController];
    [self passManagedObjectModel:_managedObjectModel toObject:_detailViewController];
	
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
    
}


#pragma mark - Application Notifications (Internal)

- (void) masterDisplayRequested:(NSNotification *)notification 
{	
	// Open the notification, pull out the object
	NSObject *notificationObject		= [notification object];
	
	// Request the correct view controller
	UIViewController *newViewController =  [ self newMasterControllerFor:notificationObject ];
	
	if ( newViewController ) {
		
		[_navigationController pushViewController:newViewController animated:YES];
		
	} else {
		
		// No controller returned, pop all
		[_navigationController popToRootViewControllerAnimated:YES];
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
		NSArray *viewControllers = [[NSArray alloc] initWithObjects:_navigationController, newViewController, nil];
		_splitViewController.viewControllers = viewControllers;
		
        // Release the viewController that was returned.
        
    } else {
        
        // Update the split view controller's view controllers array. Pop back to default detail display.
		NSArray *viewControllers = [[NSArray alloc] initWithObjects:_navigationController, [self detailViewController], nil];
		_splitViewController.viewControllers = viewControllers;
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
