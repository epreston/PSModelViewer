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


@protocol PSAcceptsManagedObjectContext <NSObject>

@required
@property (nonatomic, retain) NSManagedObjectContext		*managedObjectContext;

@end


@protocol PSAcceptsManagedObjectModel <NSObject>

@required
@property (nonatomic, retain) NSManagedObjectModel			*managedObjectModel;

@end


@protocol PSAcceptsEntityDescription <NSObject>

@required
@property (nonatomic, retain) NSEntityDescription			*detailEntityDescription;

@end


@protocol PSAcceptsFetchRequest <NSObject>

@required
@property (nonatomic, retain) NSFetchRequest				*detailFetchRequest;

@end


@protocol PSAcceptsAttributeDescription <NSObject>

@required
@property (nonatomic, retain) NSAttributeDescription		*detailAttributeDescription;

@end


@protocol PSAcceptsRelationshipDescription <NSObject>

@required
@property (nonatomic, retain) NSRelationshipDescription		*detailRelationshipDescription;

@end


@protocol PSAcceptsFetchedPropertyDescription <NSObject>

@required
@property (nonatomic, retain) NSFetchedPropertyDescription	*detailFetchedPropertyDescription;

@end

// It makes sense to have all 3
@protocol PSAcceptsManagedObjects <NSObject>

@required
@property (nonatomic, retain) NSManagedObject				*detailObject;

@optional
@property (nonatomic, retain) NSEntityDescription			*detailEntityDescription;
@property (nonatomic, retain) NSManagedObjectContext		*managedObjectContext;

@end


@protocol PSAcceptsSets <NSObject>

@required
@property (nonatomic, retain) NSSet							*detailSet;

@end


@protocol PSAcceptsString <NSObject>

@required
@property (nonatomic, retain) NSString						*detailString;

@end


@protocol PSAcceptsArray <NSObject>

@required
@property (nonatomic, retain) NSArray						*detailArray;

@end


