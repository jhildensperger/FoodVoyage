#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface IngredientLine : NSManagedObject

@property (nonatomic) NSString *string;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary;

@end
