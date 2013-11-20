#import "RecipeDetailViewController.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "Image.h"
#import "UIImageView+AFNetworking.h"

@interface RecipeDetailViewController ()

@property (nonatomic) Recipe *recipe;

@end

@implementation RecipeDetailViewController

#define TYPE_SECTION 0
#define INGREDIENTS_SECTION 1


#pragma mark -
#pragma mark View controller

- (instancetype)initWithRecipe:(Recipe *)recipe {
    if (self = [super init]) {
        self.recipe = recipe;
    }
    return self;
}

- (void)viewDidLoad {
    if (self.tableHeaderView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:self options:nil];
        self.tableView.tableHeaderView = self.tableHeaderView;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
	
    [self.photoImageView setImageWithURL:self.recipe.image.mediumURL];
	self.title = self.recipe.name;
    self.nameTextField.text = self.recipe.name;
    self.overviewTextField.text = self.recipe.cuisine;
    self.prepTimeTextField.text = [NSString stringWithFormat:@"%i minutes", self.recipe.time.intValue/60];

	// Update recipe type and ingredients on return.
    [self.tableView reloadData]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark UITableView Delegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    // Return a title or nil as appropriate for the section.
    switch (section) {
        case TYPE_SECTION:
            title = @"Category";
            break;
        case INGREDIENTS_SECTION:
            title = @"Ingredients";
            break;
        default:
            break;
    }
    return title;;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == INGREDIENTS_SECTION ? [self.recipe.ingredients count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
     // For the Ingredients section, if necessary create a new cell and configure it with an additional label for the amount.  Give the cell a different identifier from that used for cells in other sections so that it can be dequeued separately.
    if (indexPath.section == INGREDIENTS_SECTION) {
		NSUInteger ingredientCount = [self.recipe.ingredients count];
        NSInteger row = indexPath.row;
		
        if (indexPath.row < ingredientCount) {
            // If the row is within the range of the number of ingredients for the current recipe, then configure the cell to show the ingredient name and amount.
			static NSString *IngredientsCellIdentifier = @"IngredientsCell";
			
			cell = [tableView dequeueReusableCellWithIdentifier:IngredientsCellIdentifier];
			
			if (cell == nil) {
				 // Create a cell to display an ingredient.
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IngredientsCellIdentifier];
			}
			
            Ingredient *ingredient = [self.recipe.ingredients.allObjects objectAtIndex:row];
            cell.textLabel.text = ingredient.name;
//			cell.detailTextLabel.text = ingredient.amount;
        }
    } else {
         // If necessary create a new cell and configure it appropriately for the section.  Give the cell a different identifier from that used for cells in the Ingredients section so that it can be dequeued separately.
        static NSString *MyIdentifier = @"GenericCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        NSString *text = nil;
        
        switch (indexPath.section) {
            case TYPE_SECTION: // type -- should be selectable -> checkbox
                text = [self.recipe.cuisine valueForKey:@"name"];
                break;
            default:
                break;
        }
        
        cell.textLabel.text = text;
    }
    return cell;
}

@end
