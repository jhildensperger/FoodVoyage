#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

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

- (void)addIngredientsObject:(Recipe *)value;
- (void)removeIngredientsObject:(Recipe *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;

- (void)insertObject:(Recipe *)value inIngredientLinesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIngredientLinesAtIndex:(NSUInteger)idx;
- (void)insertIngredientLines:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIngredientLinesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIngredientLinesAtIndex:(NSUInteger)idx withObject:(Recipe *)value;
- (void)replaceIngredientLinesAtIndexes:(NSIndexSet *)indexes withIngredientLines:(NSArray *)values;
- (void)addIngredientLinesObject:(Recipe *)value;
- (void)removeIngredientLinesObject:(Recipe *)value;
- (void)addIngredientLines:(NSOrderedSet *)values;
- (void)removeIngredientLines:(NSOrderedSet *)values;
@end
