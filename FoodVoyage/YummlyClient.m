#import "YummlyClient.h"

static NSString * const YummlyAPIBaseURLString = @"https://api.yummly.com/v1/api/";
static NSString * const YummlyAppID = @"14a63f71";
static NSString * const YummlyAppKey = @"d0c2317e879e89ec4bdbe9785bf0bcc0";

@implementation YummlyClient

+ (instancetype)sharedClient {
    static YummlyClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        urlSessionConfig.HTTPAdditionalHeaders =@{@"X-Yummly-App-ID": YummlyAppID,
                                                  @"X-Yummly-App-Key": YummlyAppKey};
        
        _sharedClient = [[YummlyClient alloc] initWithBaseURL:[NSURL URLWithString:YummlyAPIBaseURLString] sessionConfiguration:urlSessionConfig];
    });
    
    return _sharedClient;
}
@end
