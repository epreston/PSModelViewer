//
//  PSModelDetailsController.h
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import	"PSBaseDetailViewController.h"
#import "PSSmallItemUI.h"


@class PSGridScrollView;


@interface PSModelDetailsController : PSBaseDetailViewController 
    < PSAcceptsManagedObjectModel, PSSmallItemUIDelegate > 
{

	NSManagedObjectModel			*managedObjectModel;
	
@private
    
	// User Interface - Stats
	UILabel							*numberOfEntities;
	UILabel							*numberOfConfigurations;
	UILabel							*numberOfFetchRequestTemplates;
	
	PSGridScrollView				*gridView;
}

@property (nonatomic, retain) NSManagedObjectModel			*managedObjectModel;

@property (nonatomic, retain) IBOutlet UILabel				*numberOfEntities;
@property (nonatomic, retain) IBOutlet UILabel				*numberOfConfigurations;
@property (nonatomic, retain) IBOutlet UILabel				*numberOfFetchRequestTemplates;

@property (nonatomic, retain) IBOutlet PSGridScrollView		*gridView;

- (void) configureView;

@end
