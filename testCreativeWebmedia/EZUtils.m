

#import "EZUtils.h"

@interface EZUtils ()

@end

@implementation EZUtils

// singleton instance
+(EZUtils*)instance
{
    static EZUtils *util = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [EZUtils new];
    });
    return util;
}

//round views corners
- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color  {
    CALayer *layer = [view layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    layer.borderWidth = border;
    layer.borderColor = color.CGColor;
}


-(CGSize)getHeightOfTexts:(NSString*)text widthOfTextView:(CGFloat)width withFont:(UIFont*)font
{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:font}
                                                 context:nil];
    
    return textRect.size;
}


@end
