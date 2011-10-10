//
//  PSBaseContentController.h
//  - Not project specific
//
//  Created by Ed Preston on 7/4/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PSBaseContentController : NSObject 
{	
    
@protected
    
    NSManagedObjectContext	*managedObjectContext_;
    
@private
    
	UISplitViewController	*splitViewController_;
	UINavigationController	*navigationController_;
	
	UIViewController		*rootViewController_;
}

@property (nonatomic, retain) IBOutlet	UISplitViewController	*splitViewController;
@property (nonatomic, retain) IBOutlet	UINavigationController	*navigationController;
@property (nonatomic, retain) IBOutlet	UIViewController		*rootViewController;

@property (nonatomic, retain)			NSManagedObjectContext	*managedObjectContext;

- (UIView *) view;


// IMPLEMENT IN SUBCLASS
- (UIViewController *) masterDisplayControllerFor:(NSObject *)anObject;
- (UIViewController *) detailDisplayControllerFor:(NSObject *)anObject;


// HELPERS
- (void) passManagedObjectContext:(NSManagedObjectContext *)objectContext toObject:(NSObject *) targetObject;
- (void) passManagedObjectModel:(NSManagedObjectModel *)objectModel toObject:(NSObject *) targetObject;
- (void) passEntityDescription:(NSEntityDescription *)entityDescription toObject:(NSObject *) targetObject;
- (void) passFetchRequest:(NSFetchRequest *)fetchRequest toObject:(NSObject *) targetObject;
- (void) passAttributeDescription:(NSAttributeDescription *)attributeDescription toObject:(NSObject *) targetObject;
- (void) passRelationshipDescription:(NSRelationshipDescription *)relationshipDescription toObject:(NSObject *) targetObject;
- (void) passFetchedPropertyDescription:(NSFetchedPropertyDescription *)fetchedPropertyDescription toObject:(NSObject *) targetObject;
- (void) passManagedObject:(NSManagedObject *)managedObject toObject:(NSObject *) targetObject;
- (void) passSet:(NSSet *)aSet toObject:(NSObject *) targetObject;
- (void) passString:(NSString *)aString toObject:(NSObject *) targetObject;
- (void) passArray:(NSArray *)anArray toObject:(NSObject *) targetObject;
// - (void) passObject:(NSObject *)anObject toObject:(NSObject *) targetObject;

@end
