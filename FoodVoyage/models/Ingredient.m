#import "Ingredient.h"
#import "KZPropertyMapper.h"

@implementation Ingredient

@dynamic name;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary {
    BOOL result = [KZPropertyMapper mapValuesFrom:dictionary
                                       toInstance:self
                                     usingMapping:@{
                                                    @"name" : KZProperty(name)
                                                    }];
    return result;
}

@end
