//
//  PSContentController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSContentController.h"


// Headers for specific display controller types.

// Master
#import "PSModelListController.h"
#import "PSConfigListController.h"
#import	"PSEntityListController.h"
#import "PSFetchListController.h"


// Detail
#import "PSModelDetailsController.h"
#import "PSEntityDetailsController.h"
#import "PSAttributeDetailsController.h"
#import "PSRelationshipDetailsController.h"
#import "PSFetchedPropertyDetailsController.h"
#import "PSFetchedTemplateDetailsController.h"


@interface PSContentController ()
- (UIViewController *) loadDefaultDetailController;
@end


@implementation PSContentController

@synthesize currentMasterViewController, currentDetailViewController;
@synthesize lastDetailObject, lastMasterObject;


#pragma mark - Object LifeCycle

- (void) awakeFromNib 
{	
	// Call Super
	[super awakeFromNib];
	
	// Pass along the managed object context to detail view
	[self passManagedObjectContext:managedObjectContext toObject:currentDetailViewController];
}

- (void) dealloc 
{	
	ERS_RELEASE_SAFELY( currentMasterViewController );				   
	ERS_RELEASE_SAFELY( currentDetailViewController );
	
	ERS_RELEASE_SAFELY( lastMasterObject );
	ERS_RELEASE_SAFELY( lastDetailObject );
	
    [super dealloc];
}


#pragma mark - Support Code

- (UIViewController *) loadDefaultDetailController 
{	
	return [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil];
}


#pragma mark - Master Display Contoller Lookup

- (UIViewController *) masterDisplayControllerFor:(NSObject *)anObject 
{	
	// Process object if is was provided, if not, drop all state and pop all view contollers to root
	if ( !anObject ) {
		
		ERS_RELEASE_SAFELY( lastMasterObject );
		ERS_RELEASE_SAFELY( currentMasterViewController );
		
		return nil;
	}
	
	// Short circut evalutation
	if ( lastMasterObject ) {
		if ( [anObject isKindOfClass:[lastMasterObject class]] ) {
			
			//NSLog( @"Same master view controller requested twice for object class: %@", [lastMasterObject description] );
			// return currentMasterViewController;
		}
	}
	
	// Something new, drop our state information
	ERS_RELEASE_SAFELY( lastMasterObject );
	ERS_RELEASE_SAFELY( currentMasterViewController );
	
	// The new object is now our lastMasterObject
	lastMasterObject = [anObject retain];
	
	
	if ( [anObject isKindOfClass:[NSManagedObjectContext class]] ) {
		
		//currentMasterViewController = [PSModelListController alloc] ;

		// We do not pass our managed object context.
		//[self passManagedObjectContext:(NSManagedObjectContext *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObjectModel class]] ) {
		
		currentMasterViewController = [PSModelListController alloc] ;

		[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		[self passManagedObjectModel:(NSManagedObjectModel *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSEntityDescription class]] ) {
		
		currentMasterViewController = [PSEntityListController alloc] ;

		[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		[self passEntityDescription:(NSEntityDescription *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSFetchRequest class]] ) {
		
		currentMasterViewController = [PSFetchListController alloc] ;

		[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		[self passFetchRequest:(NSFetchRequest *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSAttributeDescription class]] ) {
		
		//currentMasterViewController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passAttributeDescription:(NSAttributeDescription *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSRelationshipDescription class]] ) {
		
		//currentMasterViewController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passRelationshipDescription:(NSRelationshipDescription *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSFetchedPropertyDescription class]] ) {
		
		//currentMasterViewController = [PSModelListController alloc] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passFetchedPropertyDescription:(NSFetchedPropertyDescription *)anObject toObject:currentMasterViewController];
	
	} else if ( [anObject isKindOfClass:[NSManagedObject class]] ) {								   
		
		//currentMasterViewController = [PSModelListController alloc] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passManagedObject:(NSManagedObject *)anObject toObject:currentMasterViewController];
									   
	} else if ( [anObject isKindOfClass:[NSSet class]] ) {
		
		//currentMasterViewController = [PSModelListController alloc] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passSet:(NSSet *)anObject toObject:currentMasterViewController];
	
	} else if ( [anObject isKindOfClass:[NSString class]] ) { 
	
		currentMasterViewController = [PSConfigListController alloc] ;
		
		[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		[self passString:(NSString *)anObject toObject:currentMasterViewController];
									   
	} else if ( [anObject isKindOfClass:[NSArray class]] ) { 
	
		//currentMasterViewController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passArray:(NSArray *)anObject toObject:currentMasterViewController];
									   
	}
	
	// If currentMasterViewController is still nil, add support for it or find the bug
    
	return currentMasterViewController;
}


#pragma mark - Detail Display Contoller Lookup

- (UIViewController *) detailDisplayControllerFor:(NSObject *)anObject
{
	// Process object if is was provided, if not, drop all state and display welcome screen
	if ( !anObject ) {
		
		ERS_RELEASE_SAFELY( lastDetailObject );
		ERS_RELEASE_SAFELY( currentDetailViewController );
		
		currentDetailViewController = [self loadDefaultDetailController];
		
		// Pass the core data managedObjectContext to the default view controller
		[self passManagedObjectContext:managedObjectContext toObject:currentDetailViewController];
		
		return currentDetailViewController;
	}
	
	// Short circut evalutation
	if ( lastDetailObject ) {
		if ( [anObject isKindOfClass:[lastDetailObject class]] ) {
			
			//NSLog( @"Same detail view controller requested twice for object class: %@", [lastDetailObject description]  );
			//return currentDetailViewController;
		}
	}

	ERS_RELEASE_SAFELY( lastDetailObject );
	ERS_RELEASE_SAFELY( currentDetailViewController );
	
	// The new object is now our lastDetailObject
	lastDetailObject = [anObject retain];
	
	if ( [anObject isKindOfClass:[NSManagedObjectContext class]] ) {
		
		//currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		// We dont pass our managed object context.
		//[self passManagedObjectContext:(NSManagedObjectContext *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObjectModel class]] ) {
		
		currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		[self passManagedObjectModel:(NSManagedObjectModel *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSEntityDescription class]] ) {
		
		currentDetailViewController = [[PSEntityDetailsController alloc] initWithNibName:@"PSEntityDetails" bundle:nil] ;
		
		[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		[self passEntityDescription:(NSEntityDescription *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSFetchRequest class]] ) {
		
		currentDetailViewController = [[PSFetchedTemplateDetailsController alloc] initWithNibName:@"PSFetchedTemplateDetails" bundle:nil] ;
		
		[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		[self passFetchRequest:(NSFetchRequest *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSAttributeDescription class]] ) {
		
		currentDetailViewController = [[PSAttributeDetailsController alloc] initWithNibName:@"PSAttributeDetails" bundle:nil] ;
		
		[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		[self passAttributeDescription:(NSAttributeDescription *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSRelationshipDescription class]] ) {
		
		currentDetailViewController = [[PSRelationshipDetailsController alloc] initWithNibName:@"PSRelationshipDetails" bundle:nil] ;
		
		[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		[self passRelationshipDescription:(NSRelationshipDescription *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSFetchedPropertyDescription class]] ) {
		
		currentDetailViewController = [[PSFetchedPropertyDetailsController alloc] initWithNibName:@"PSFetchedPropertyDetails" bundle:nil] ;
		
		[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		[self passFetchedPropertyDescription:(NSFetchedPropertyDescription *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObject class]] ) {
		
		//currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		//[self passManagedObject:(NSManagedObject *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSSet class]] ) {
		
		//currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		//[self passSet:(NSSet *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSString class]] ) {
		
		//currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		//[self passString:(NSString *)anObject toObject: currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSArray class]] ) {
		
		//currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: currentDetailViewController];
		//[self passArray:(NSArray *)anObject toObject: currentDetailViewController];
	}

	// If currentDetailViewController is still nil, add support for it or find the bug
	
	// Return the UIViewController
	return currentDetailViewController;
}


@end
