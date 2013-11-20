@class Recipe;

@interface RecipeDetailViewController : UITableViewController

@property (nonatomic) IBOutlet UIView *tableHeaderView;
@property (nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) IBOutlet UITextField *overviewTextField;
@property (nonatomic) IBOutlet UITextField *prepTimeTextField;

- (instancetype)initWithRecipe:(Recipe *)recipe;

@end
