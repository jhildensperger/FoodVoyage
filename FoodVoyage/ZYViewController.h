//
//  ZYViewController.h
//  FoodVoyage
//
//  Created by James Hildensperger on 11/18/13.
//  Copyright (c) 2013 Zymurgical. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface ZYViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end
