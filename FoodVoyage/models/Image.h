#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Image : NSManagedObject

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary;

- (NSURL *)largeURL;
- (NSURL *)mediumURL;
- (NSURL *)smallURL;

@end
