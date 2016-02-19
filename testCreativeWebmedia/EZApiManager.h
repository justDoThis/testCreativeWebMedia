

#define SERVER_URL @"https://yalantis.com/blog/"

@interface EZApiManager : NSObject 

+ (EZApiManager *) getSharedInstance;

// main method for data
- (void) downloadDataFromUrlwithPath:(NSString*)path withAddName:(NSString*)name withCompletion:(void (^)(id result))callback;


@end
