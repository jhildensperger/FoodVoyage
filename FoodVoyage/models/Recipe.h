#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;
@class Ingredient;
@class IngredientLine;

@interface Recipe : NSManagedObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSNumber *rating;
@property (nonatomic) NSNumber *time;
@property (nonatomic) NSString *course;
@property (nonatomic) NSString *cuisine;
@property (nonatomic) NSNumber *servings;
@property (nonatomic) NSString *holiday;
@property (nonatomic) NSString *yield;
@property (nonatomic) NSSet *ingredients;
@property (nonatomic) Image *image;
@property (nonatomic) NSOrderedSet *ingredientLines;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary;

@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;

- (void)insertObject:(IngredientLine *)value inIngredientLinesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIngredientLinesAtIndex:(NSUInteger)idx;
- (void)insertIngredientLines:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIngredientLinesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIngredientLinesAtIndex:(NSUInteger)idx withObject:(IngredientLine *)value;
- (void)replaceIngredientLinesAtIndexes:(NSIndexSet *)indexes withIngredientLines:(NSArray *)values;
- (void)addIngredientLinesObject:(IngredientLine *)value;
- (void)removeIngredientLinesObject:(IngredientLine *)value;
- (void)addIngredientLines:(NSOrderedSet *)values;
- (void)removeIngredientLines:(NSOrderedSet *)values;
@end
