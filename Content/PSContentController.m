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

- (UIViewController *) newMasterControllerFor:(NSObject *)anObject;
- (UIViewController *) newDetailControllerFor:(NSObject *)anObject;

@end


@implementation PSContentController


#pragma mark - Master Display Contoller Lookup

- (UIViewController *) newMasterControllerFor:(NSObject *)anObject 
{	
    UIViewController *newController = nil;
    
	// Process object if is was provided, if not, drop all state and pop all view contollers to root
	if ( !anObject ) {
		return newController;
	}
	
	if ( [anObject isKindOfClass:[NSManagedObjectContext class]] ) {

		// We do not pass our managed object context.
		//[self passManagedObjectContext:(NSManagedObjectContext *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObjectModel class]] ) {
		
		newController = [[PSModelListController alloc] init] ;

//		[self passManagedObjectContext:self.managedObjectContext toObject:newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passManagedObjectModel:(NSManagedObjectModel *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSEntityDescription class]] ) {
		
		newController = [[PSEntityListController alloc] init] ;

//		[self passManagedObjectContext:self.managedObjectContext toObject:newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passEntityDescription:(NSEntityDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSFetchRequest class]] ) {
		
		newController = [[PSFetchListController alloc] init] ;

//		[self passManagedObjectContext:self.managedObjectContext toObject:newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passFetchRequest:(NSFetchRequest *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSAttributeDescription class]] ) {
		
		//newController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:newController];
		//[self passAttributeDescription:(NSAttributeDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSRelationshipDescription class]] ) {
		
		//newController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:newController];
		//[self passRelationshipDescription:(NSRelationshipDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSFetchedPropertyDescription class]] ) {
		
		//newController = [PSModelListController alloc] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject:newController];
		//[self passFetchedPropertyDescription:(NSFetchedPropertyDescription *)anObject toObject:newController];
	
	} else if ( [anObject isKindOfClass:[NSManagedObject class]] ) {								   
		
		//newController = [PSModelListController alloc] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject:newController];
		//[self passManagedObject:(NSManagedObject *)anObject toObject:newController];
									   
	} else if ( [anObject isKindOfClass:[NSSet class]] ) {
		
		//newController = [PSModelListController alloc] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject:newController];
		//[self passSet:(NSSet *)anObject toObject:newController];
	
	} else if ( [anObject isKindOfClass:[NSString class]] ) { 
	
		newController = [[PSConfigListController alloc] init] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject:newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passString:(NSString *)anObject toObject:newController];
									   
	} else if ( [anObject isKindOfClass:[NSArray class]] ) { 
	
		//newController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:newController];
		//[self passArray:(NSArray *)anObject toObject:newController];
									   
	}
	
	// If currentMasterViewController is still nil, add support for it or find the bug
    
	return newController;
}


#pragma mark - Detail Display Contoller Lookup

- (UIViewController *) newDetailControllerFor:(NSObject *)anObject
{
    UIViewController *newController = nil;
    
	// Process object if is was provided, if not, drop all state and display welcome screen
	if ( !anObject ) {
		
        // Like all good things, the initial detail view controller is constant.  An extra retain
        // is added to ensure it is not released by calling methods.
		return [[self detailViewController] retain];
	}
	
	if ( [anObject isKindOfClass:[NSManagedObjectContext class]] ) {
		
		//newController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		// We dont pass our managed object context.
		
	} else if ( [anObject isKindOfClass:[NSManagedObjectModel class]] ) {
		
		newController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" 
                                                                   bundle:nil] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject: newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passManagedObjectModel:(NSManagedObjectModel *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSEntityDescription class]] ) {
		
		newController = [[PSEntityDetailsController alloc] initWithNibName:@"PSEntityDetails" 
                                                                    bundle:nil] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject: newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passEntityDescription:(NSEntityDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSFetchRequest class]] ) {
		
		newController = [[PSFetchedTemplateDetailsController alloc] initWithNibName:@"PSFetchedTemplateDetails" 
                                                                             bundle:nil] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject: newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passFetchRequest:(NSFetchRequest *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSAttributeDescription class]] ) {
		
		newController = [[PSAttributeDetailsController alloc] initWithNibName:@"PSAttributeDetails" 
                                                                       bundle:nil] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject: newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passAttributeDescription:(NSAttributeDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSRelationshipDescription class]] ) {
		
		newController = [[PSRelationshipDetailsController alloc] initWithNibName:@"PSRelationshipDetails" 
                                                                          bundle:nil] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject: newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passRelationshipDescription:(NSRelationshipDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSFetchedPropertyDescription class]] ) {
		
		newController = [[PSFetchedPropertyDetailsController alloc] initWithNibName:@"PSFetchedPropertyDetails" 
                                                                             bundle:nil] ;
		
//		[self passManagedObjectContext:self.managedObjectContext toObject: newController];
        [self passManagedObjectModel:self.managedObjectModel toObject:newController];
		[self passFetchedPropertyDescription:(NSFetchedPropertyDescription *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObject class]] ) {
		
		//newController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: newController];
		//[self passManagedObject:(NSManagedObject *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSSet class]] ) {
		
		//newController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: newController];
		//[self passSet:(NSSet *)anObject toObject:newController];
		
	} else if ( [anObject isKindOfClass:[NSString class]] ) {
		
		//newController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: newController];
		//[self passString:(NSString *)anObject toObject: newController];
		
	} else if ( [anObject isKindOfClass:[NSArray class]] ) {
		
		//newController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		//[self passManagedObjectContext:managedObjectContext toObject: newController];
		//[self passArray:(NSArray *)anObject toObject: newController];
	}

	// If newController is still nil, add support for it or find the bug
	
	// Return the UIViewController
	return newController;
}


@end
