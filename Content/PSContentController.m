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

- (UIViewController *) newDefaultDetailController;

@end


@implementation PSContentController

@synthesize currentMasterViewController = currentMasterViewController_;
@synthesize currentDetailViewController = currentDetailViewController_;


#pragma mark - Object LifeCycle

- (void) awakeFromNib 
{	
	// Call Super
	[super awakeFromNib];
	
	// Pass along the managed object context to detail view
	[self passManagedObjectContext:self.managedObjectContext toObject:currentDetailViewController_];
}

- (void) dealloc 
{	
    
    [super dealloc];
}


#pragma mark - Support Code

- (UIViewController *) newDefaultDetailController 
{	
	return [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil];
}


#pragma mark - Master Display Contoller Lookup

- (UIViewController *) masterDisplayControllerFor:(NSObject *)anObject 
{	
	// Process object if is was provided, if not, drop all state and pop all view contollers to root
	if ( !anObject ) {
		
//        self.lastMasterObject = nil;
        self.currentDetailViewController = nil;
		
		return nil;
	}
	
	if ( [anObject isKindOfClass:[NSManagedObjectContext class]] ) {
		
		//currentMasterViewController = [PSModelListController alloc] ;

		// We do not pass our managed object context.
		//[self passManagedObjectContext:(NSManagedObjectContext *)anObject toObject:currentMasterViewController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObjectModel class]] ) {
		
		self.currentMasterViewController = [PSModelListController alloc] ;

		[self passManagedObjectContext:self.managedObjectContext toObject:currentMasterViewController_];
		[self passManagedObjectModel:(NSManagedObjectModel *)anObject toObject:currentMasterViewController_];
		
	} else if ( [anObject isKindOfClass:[NSEntityDescription class]] ) {
		
		self.currentMasterViewController = [PSEntityListController alloc] ;

		[self passManagedObjectContext:self.managedObjectContext toObject:currentMasterViewController_];
		[self passEntityDescription:(NSEntityDescription *)anObject toObject:currentMasterViewController_];
		
	} else if ( [anObject isKindOfClass:[NSFetchRequest class]] ) {
		
		self.currentMasterViewController = [PSFetchListController alloc] ;

		[self passManagedObjectContext:self.managedObjectContext toObject:currentMasterViewController_];
		[self passFetchRequest:(NSFetchRequest *)anObject toObject:currentMasterViewController_];
		
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
	
		self.currentMasterViewController = [PSConfigListController alloc] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject:currentMasterViewController_];
		[self passString:(NSString *)anObject toObject:currentMasterViewController_];
									   
	} else if ( [anObject isKindOfClass:[NSArray class]] ) { 
	
		//currentMasterViewController = [PSModelListController alloc] ;

		//[self passManagedObjectContext:managedObjectContext toObject:currentMasterViewController];
		//[self passArray:(NSArray *)anObject toObject:currentMasterViewController];
									   
	}
	
	// If currentMasterViewController is still nil, add support for it or find the bug
    
	return currentMasterViewController_;
}


#pragma mark - Detail Display Contoller Lookup

- (UIViewController *) detailDisplayControllerFor:(NSObject *)anObject
{
	// Process object if is was provided, if not, drop all state and display welcome screen
	if ( !anObject ) {
		
		self.currentDetailViewController = [self newDefaultDetailController];
		
		// Pass the core data managedObjectContext to the default view controller
		[self passManagedObjectContext:self.managedObjectContext toObject:currentDetailViewController_];
		
		return [[currentDetailViewController_ retain] autorelease];
	}
	
	if ( [anObject isKindOfClass:[NSManagedObjectContext class]] ) {
		
		//currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		// We dont pass our managed object context.
		//[self passManagedObjectContext:(NSManagedObjectContext *)anObject toObject:currentDetailViewController];
		
	} else if ( [anObject isKindOfClass:[NSManagedObjectModel class]] ) {
		
		self.currentDetailViewController = [[PSModelDetailsController alloc] initWithNibName:@"PSModelDetails" bundle:nil] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject: currentDetailViewController_];
		[self passManagedObjectModel:(NSManagedObjectModel *)anObject toObject:currentDetailViewController_];
		
	} else if ( [anObject isKindOfClass:[NSEntityDescription class]] ) {
		
		self.currentDetailViewController = [[PSEntityDetailsController alloc] initWithNibName:@"PSEntityDetails" bundle:nil] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject: currentDetailViewController_];
		[self passEntityDescription:(NSEntityDescription *)anObject toObject:currentDetailViewController_];
		
	} else if ( [anObject isKindOfClass:[NSFetchRequest class]] ) {
		
		self.currentDetailViewController = [[PSFetchedTemplateDetailsController alloc] initWithNibName:@"PSFetchedTemplateDetails" bundle:nil] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject: currentDetailViewController_];
		[self passFetchRequest:(NSFetchRequest *)anObject toObject:currentDetailViewController_];
		
	} else if ( [anObject isKindOfClass:[NSAttributeDescription class]] ) {
		
		self.currentDetailViewController = [[PSAttributeDetailsController alloc] initWithNibName:@"PSAttributeDetails" bundle:nil] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject: currentDetailViewController_];
		[self passAttributeDescription:(NSAttributeDescription *)anObject toObject:currentDetailViewController_];
		
	} else if ( [anObject isKindOfClass:[NSRelationshipDescription class]] ) {
		
		self.currentDetailViewController = [[PSRelationshipDetailsController alloc] initWithNibName:@"PSRelationshipDetails" bundle:nil] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject: currentDetailViewController_];
		[self passRelationshipDescription:(NSRelationshipDescription *)anObject toObject:currentDetailViewController_];
		
	} else if ( [anObject isKindOfClass:[NSFetchedPropertyDescription class]] ) {
		
		self.currentDetailViewController = [[PSFetchedPropertyDetailsController alloc] initWithNibName:@"PSFetchedPropertyDetails" bundle:nil] ;
		
		[self passManagedObjectContext:self.managedObjectContext toObject: currentDetailViewController_];
		[self passFetchedPropertyDescription:(NSFetchedPropertyDescription *)anObject toObject:currentDetailViewController_];
		
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
	return [[currentDetailViewController_ retain] autorelease];
}


@end
