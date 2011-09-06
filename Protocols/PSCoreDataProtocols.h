//
//  PSCoreDataProtocols.h
//  - Not project specific
//
//  Created by Ed Preston on 7/2/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <CoreData/CoreData.h>


/*
 
 I know these are really small but they allow me to write very generic functions.  I can
 then throw all the information I have at an object, and it takes what it needs from the
 feed of information.
 
 */


@protocol PSAcceptsManagedObjectContext
@property (nonatomic, retain) NSManagedObjectContext		*managedObjectContext;
@end


@protocol PSAcceptsManagedObjectModel
@property (nonatomic, retain) NSManagedObjectModel			*managedObjectModel;
@end


@protocol PSAcceptsEntityDescription
@property (nonatomic, retain) NSEntityDescription			*detailEntityDescription;
@end


@protocol PSAcceptsFetchRequest
@property (nonatomic, retain) NSFetchRequest				*detailFetchRequest;
@end


@protocol PSAcceptsAttributeDescription
@property (nonatomic, retain) NSAttributeDescription		*detailAttributeDescription;
@end


@protocol PSAcceptsRelationshipDescription
@property (nonatomic, retain) NSRelationshipDescription		*detailRelationshipDescription;
@end


@protocol PSAcceptsFetchedPropertyDescription
@property (nonatomic, retain) NSFetchedPropertyDescription	*detailFetchedPropertyDescription;
@end

// It makes sense to have all 3
@protocol PSAcceptsManagedObjects
@property (nonatomic, retain) NSManagedObject				*detailObject;
@property (nonatomic, retain) NSEntityDescription			*detailEntityDescription;
@property (nonatomic, retain) NSManagedObjectContext		*managedObjectContext;
@end


@protocol PSAcceptsSets
@property (nonatomic, retain) NSSet							*detailSet;
@end


@protocol PSAcceptsString
@property (nonatomic, retain) NSString						*detailString;
@end


@protocol PSAcceptsArray
@property (nonatomic, retain) NSArray						*detailArray;
@end


