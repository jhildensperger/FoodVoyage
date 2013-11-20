//
//  ZYViewController.m
//  FoodVoyage
//
//  Created by James Hildensperger on 11/18/13.
//  Copyright (c) 2013 Zymurgical. All rights reserved.
//

#import "ZYViewController.h"
#import "YummlyClient.h"
#import "RecipeTableViewCell.h"
#import "RecipeDetailViewController.h"

@interface ZYViewController ()

@property (nonatomic) NSString *nationality;

@end

@implementation ZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchRecipes];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(fetchRecipes) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view becomeFirstResponder];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.view resignFirstResponder];
    [super viewWillDisappear:animated];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects] ? [sectionInfo numberOfObjects] : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue or if necessary create a RecipeTableViewCell, then set its recipe to the recipe for the current row.
    static NSString *RecipeCellIdentifier = @"RecipeCellIdentifier";
    
    RecipeTableViewCell *recipeCell = (RecipeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:RecipeCellIdentifier];
    if (recipeCell == nil) {
        recipeCell = [[RecipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipeCellIdentifier];
		recipeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	[self configureCell:recipeCell atIndexPath:indexPath];
    
    return recipeCell;
}

- (void)configureCell:(RecipeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	Recipe *recipe = (Recipe *)[_fetchedResultsController objectAtIndexPath:indexPath];
    cell.nameLabel.text = recipe.name;
    cell.ratingLabel.text = recipe.rating.stringValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Recipe *recipe = (Recipe *)[_fetchedResultsController objectAtIndexPath:indexPath];
    [self showRecipe:recipe animated:YES];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (!_fetchedResultsController) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        _fetchedResultsController.delegate = self;
    }
	
	return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tableView = self.tableView;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:(RecipeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
}

- (void)showRecipe:(Recipe *)recipe animated:(BOOL)animated {
    // Create a detail view controller, set the recipe, then push it.
    RecipeDetailViewController *detailViewController = [[RecipeDetailViewController alloc] initWithRecipe:recipe];
    [self.navigationController pushViewController:detailViewController animated:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self fetchRecipes];
    }
    
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)fetchRecipes {
    self.nationality = [self nationalities][arc4random_uniform([[self nationalities] count])];

    [[YummlyClient sharedClient] GET:@"recipes" parameters:@{@"q": self.nationality} success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.refreshControl endRefreshing];
        [self.fetchedResultsController.fetchedObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.managedObjectContext deleteObject:obj];
        }];
        
        self.title = [NSString stringWithFormat:@"%@%@%@", [responseObject[@"matches"] count] ? @"" : @"No ", self.nationality, @" Recipes"];
        
        [responseObject[@"matches"] enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:self.managedObjectContext];
            Recipe *recipe = [[Recipe alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
            [recipe updateFromDictionary:dictionary];
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.refreshControl endRefreshing];
        NSLog(@"%@", error);
    }];
}

- (NSArray *)nationalities {
    static NSArray *nats;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nats = @[@"Afghan", @"Albanian", @"Algerian", @"American", @"Andorran", @"Angolan", @"Antiguans", @"Argentinean", @"Armenian", @"Australian", @"Austrian", @"Azerbaijani", @"Bahamian", @"Bahraini", @"Bangladeshi", @"Barbadian", @"Barbudans", @"Batswana", @"Belarusian", @"Belgian", @"Belizean", @"Beninese", @"Bhutanese", @"Bolivian", @"Bosnian", @"Brazilian", @"British", @"Bruneian", @"Bulgarian", @"Burkinabe", @"Burmese", @"Burundian", @"Cambodian", @"Cameroonian", @"Canadian", @"Cape Verdean", @"Chadian", @"Chilean", @"Chinese", @"Colombian", @"Comoran", @"Congolese", @"Costa Rican", @"Croatian", @"Cuban", @"Cypriot", @"Czech", @"Danish", @"Djibouti", @"Dominican", @"Dutch", @"East Timorese", @"Ecuadorean", @"Egyptian", @"Emirian", @"Eritrean", @"Estonian", @"Ethiopian", @"Fijian", @"Filipino", @"Finnish", @"French", @"Gabonese", @"Gambian", @"Georgian", @"German", @"Ghanaian", @"Greek", @"Grenadian", @"Guatemalan", @"Guinean", @"Guyanese", @"Haitian", @"Herzegovinian", @"Honduran", @"Hungarian", @"Icelander", @"Indian", @"Indonesian", @"Iranian", @"Iraqi", @"Irish", @"Israeli", @"Italian", @"Ivorian", @"Jamaican", @"Japanese", @"Jordanian", @"Kazakhstani", @"Kenyan", @"Kuwaiti", @"Kyrgyz", @"Laotian", @"Latvian", @"Lebanese", @"Liberian", @"Libyan", @"Liechtensteiner", @"Lithuanian", @"Luxembourger", @"Macedonian", @"Malagasy", @"Malawian", @"Malaysian", @"Maldivan", @"Malian", @"Maltese", @"Marshallese", @"Mauritanian", @"Mauritian", @"Mexican", @"Micronesian", @"Moldovan", @"Monacan", @"Mongolian", @"Moroccan", @"Mosotho", @"Motswana", @"Mozambican", @"Namibian", @"Nauruan", @"Nepalese", @"Nicaraguan", @"Nigerian", @"Korean", @"Norwegian", @"Omani", @"Pakistani", @"Palauan", @"Panamanian", @"Papua New Guinean", @"Paraguayan", @"Peruvian", @"Polish", @"Portuguese", @"Qatari", @"Romanian", @"Russian", @"Rwandan", @"Saint Lucian", @"Salvadoran", @"Samoan", @"San Marinese", @"Sao Tomean", @"Saudi", @"Scottish", @"Senegalese", @"Serbian", @"Seychellois", @"Sierra Leonean", @"Singaporean", @"Slovakian", @"Slovenian", @"Somali", @"South African", @"Spanish", @"Sri Lankan", @"Sudanese", @"Surinamer", @"Swazi", @"Swedish", @"Swiss", @"Syrian", @"Taiwanese", @"Tajik", @"Tanzanian", @"Thai", @"Togolese", @"Tongan", @"Trinidadian", @"Tobagonian", @"Tunisian", @"Turkish", @"Tuvaluan", @"Ugandan", @"Ukrainian", @"Uruguayan", @"Uzbekistani", @"Venezuelan", @"Vietnamese", @"Welsh", @"Yemenite", @"Zambian", @"Zimbabwean"];
    });
    
    return nats;
}

@end
