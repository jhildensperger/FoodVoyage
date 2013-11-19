#import "Recipe.h"
#import "Image.h"
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
                                                    @"rating" : KZProperty(rating)
                                                    }];
    return result;
}

@end
