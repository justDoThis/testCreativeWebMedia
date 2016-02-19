

#import "EZPostsManager.h"
#import "EZPost.h"
#import "EZApiManager.h"

static EZPostsManager* _instance = nil;
static NSString * kPForSaving = @"saved_values";

static NSString * jsonPathUrl = @"json";
static NSString * imagePathUrl = @"jpg";
static NSString * stub = @"stub";

@implementation EZPostsManager

+(EZPostsManager*) getSharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _instance = [[EZPostsManager alloc] init];
        
        
    });
    return _instance;
}

- (void)loadPosts :(void (^)(NSArray* result))callback
{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    NSMutableArray * arr = [NSMutableArray new];
    
    [[EZApiManager getSharedInstance] downloadDataFromUrlwithPath:jsonPathUrl withAddName:stub withCompletion:^(id result) {
        if(result){
            
            NSError* errorL;
            NSArray *responseObject = [NSJSONSerialization JSONObjectWithData:result options:0 error:&errorL];
            [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [arr addObject:[[EZPost alloc] initWithDictionary:obj]];
            }];
            
            callback(arr);
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [defaults setObject:data forKey:kPForSaving];
            [defaults synchronize];
        }
        else    {
            NSData *data = [defaults objectForKey:kPForSaving];
            NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [defaults synchronize];
            callback(myArray);
        }
    }];
}

- (void)loadPostsPhoto :(NSString*)name callback:(void (^)(UIImage* result))callback
{
    [[EZApiManager getSharedInstance]downloadDataFromUrlwithPath:imagePathUrl withAddName:name withCompletion:^(id result) {
        
        if(result)
        {
            UIImage * im = [[UIImage alloc]initWithData:result];
            callback (im);
        }
    }];
}

@end
