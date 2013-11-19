#import "IngredientLine.h"
#import "KZPropertyMapper.h"

@implementation IngredientLine

@dynamic string;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary {
    BOOL result = [KZPropertyMapper mapValuesFrom:dictionary
                                       toInstance:self
                                     usingMapping:@{
                                                    @"ingredientLines" : KZProperty(string)
                                                    }];
    return result;
}

@end
