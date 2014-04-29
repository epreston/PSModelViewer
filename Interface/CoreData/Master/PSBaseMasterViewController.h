//
//  PSBaseMasterViewController.h
//  - Not project specific
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSCoreDataProtocols.h"

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PSBaseMasterViewController : UITableViewController < PSAcceptsManagedObjectModel >

@property (nonatomic, strong) NSManagedObjectModel  *managedObjectModel;

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


- (IBAction) showHomeDetailDisplay:(id)sender;

@end
