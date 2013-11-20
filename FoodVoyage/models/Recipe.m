#import "Recipe.h"
#import "Image.h"
#import "Ingredient.h"
#import "KZPropertyMapper.h"

@implementation Recipe

@dynamic name;
@dynamic identifier;
@dynamic rating;
@dynamic time;
@dynamic course;
@dynamic cuisine;
@dynamic servings;
@dynamic holiday;
@dynamic yield;
@dynamic ingredients;
@dynamic image;
@dynamic ingredientLines;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary {
    BOOL result = [KZPropertyMapper mapValuesFrom:dictionary
                                       toInstance:self
                                     usingMapping:@{
                                                    @"recipeName" : KZProperty(name),
                                                    @"rating" : KZProperty(rating),
                                                    @"totalTimeInSeconds" : KZProperty(time),
                                                    @"attributes.cuisine" :KZProperty(cuisine),
                                                    }];
    
    [dictionary[@"ingredients"] enumerateObjectsUsingBlock:^(NSString *ingredientName, NSUInteger idx, BOOL *stop) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        Ingredient *ingredient = [[Ingredient alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
        ingredient.name = ingredientName;
        [self addIngredientsObject:ingredient];
    }];
    
    

    return result;
}

@end
