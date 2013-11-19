#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Ingredient : NSManagedObject

@property (nonatomic) NSString *name;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary;

@end
