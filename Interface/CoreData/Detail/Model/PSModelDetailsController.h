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

@protected
    
	NSManagedObjectModel	*managedObjectModel_;
	
@private
    
	// User Interface - Stats
	UILabel				*numberOfEntities_;
	UILabel				*numberOfConfigurations_;
	UILabel				*numberOfFetchRequestTemplates_;
	
	PSGridScrollView	*gridView_;
}

@property (nonatomic, retain) NSManagedObjectModel			*managedObjectModel;

@property (nonatomic, assign) IBOutlet UILabel				*numberOfEntities;
@property (nonatomic, assign) IBOutlet UILabel				*numberOfConfigurations;
@property (nonatomic, assign) IBOutlet UILabel				*numberOfFetchRequestTemplates;

@property (nonatomic, assign) IBOutlet PSGridScrollView		*gridView;


@end
