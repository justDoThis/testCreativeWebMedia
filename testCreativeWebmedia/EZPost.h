

@interface EZPost : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSNumber*  rate;
@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) UIImage * image;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;
- (id)initWithDictionary:(NSDictionary *)dictionary;
-(NSString*)getRate;
-(NSString*)getHTMLStringFromPost;

@end
