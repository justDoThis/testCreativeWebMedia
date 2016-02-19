

#import "EZPost.h"

static NSString * kDesc = @"desc";
static NSString * kTit = @"title";
static NSString * kAuth = @"author";
static NSString * kRate = @"rate";
static NSString * kImUrl = @"image";


@implementation EZPost


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    _title = dictionary[kTit];
    _desc = dictionary[kDesc];
    _author = dictionary[kAuth];
    _imageUrl = dictionary[kImUrl];
    _rate = dictionary[kRate];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_title forKey:kTit];
    [coder encodeObject:_desc forKey:kDesc];
    [coder encodeObject:_author forKey:kAuth];
    [coder encodeObject:_imageUrl forKey:kImUrl];
    [coder encodeObject:_rate forKey:kRate];
}

-(NSString*)getRate
{
    return [NSString stringWithFormat:@"%@",_rate];
}

-(NSString*)getHTMLStringFromPost
{
    return [_desc stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self != nil)
    {
        _title = [coder decodeObjectForKey:kTit];
        _desc = [coder decodeObjectForKey:kDesc];
        _author = [coder decodeObjectForKey:kAuth];
        _imageUrl = [coder decodeObjectForKey:kImUrl];
        _rate = [coder decodeObjectForKey:kRate];
    }
    return self;
}
@end
