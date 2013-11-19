#import "Image.h"
#import "KZPropertyMapper.h"

@interface Image ()

@property (nonatomic) NSString *largeUrlString;
@property (nonatomic) NSString *mediumUrlString;
@property (nonatomic) NSString *smallUrlString;

@end

@implementation Image

@dynamic largeUrlString;
@dynamic mediumUrlString;
@dynamic smallUrlString;

- (BOOL)updateFromDictionary:(NSDictionary *)dictionary {
    BOOL result = [KZPropertyMapper mapValuesFrom:dictionary
                                       toInstance:self
                                     usingMapping:@{
                                                    @"largeUrl" : KZProperty(largeUrlString),
                                                    @"mediumUrl" : KZProperty(mediumUrlString),
                                                    @"smallUrl" : KZProperty(smallUrlString)
                                                    }];
    return result;
}

- (NSURL *)largeURL {
    return [NSURL URLWithString:self.largeUrlString];
}

- (NSURL *)mediumURL {
    return [NSURL URLWithString:self.mediumUrlString];
}

- (NSURL *)smallURL {
    return [NSURL URLWithString:self.smallUrlString];
}

@end
