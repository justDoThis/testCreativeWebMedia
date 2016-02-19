

#import "EZApiManager.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

static EZApiManager* _instance = nil;

@implementation EZApiManager

+(EZApiManager*) getSharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _instance = [[EZApiManager alloc] init];
    });
    return _instance;
}

//init stub for local json
-(void)initStubWithPath:(NSString*)path withStub:(NSString*)stub
{
    static id<OHHTTPStubsDescriptor> textStub = nil; // Note: no need to retain this value, it is retained by the OHHTTPStubs itself already
    // Install
    textStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        // This stub will only configure stub requests for "*.txt" files
        return [request.URL.pathExtension isEqualToString:path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        // Stub txt files with this
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile([NSString stringWithFormat:@"%@.%@",stub,path], self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"text/plain"}]
                requestTime:2.0f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
}

- (void) downloadDataFromUrlwithPath:(NSString*)path withAddName:(NSString*)name withCompletion:(void (^)(id result))callback
{
    [self initStubWithPath:path withStub:name];
    
    NSURL *fullUrl = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@.%@",SERVER_URL,name,path]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:fullUrl   completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        
        callback(data);
        
    }] resume];
}

@end
