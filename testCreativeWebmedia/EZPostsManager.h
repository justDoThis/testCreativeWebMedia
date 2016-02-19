
@interface EZPostsManager : NSObject

+ (EZPostsManager *) getSharedInstance;

// main method for data
- (void)loadPosts :(void (^)(NSArray* result))callback;
- (void)loadPostsPhoto :(NSString*)name callback:(void (^)(UIImage* result))callback;

@end
