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
    < PSSmallItemUIDelegate >
{

@private
    
	// User Interface - Stats
	UILabel				*numberOfEntities_;
	UILabel				*numberOfConfigurations_;
	UILabel				*numberOfFetchRequestTemplates_;
	
	PSGridScrollView	*gridView_;
    
    // NIB Caching to speed up load (requires iOS 4.0 +)
    UINib               *cachedEntityViewNib;
}

// Interface
@property (nonatomic, assign) IBOutlet UILabel			*numberOfEntities;
@property (nonatomic, assign) IBOutlet UILabel			*numberOfConfigurations;
@property (nonatomic, assign) IBOutlet UILabel			*numberOfFetchRequestTemplates;

@property (nonatomic, assign) IBOutlet PSGridScrollView	*gridView;

@end
