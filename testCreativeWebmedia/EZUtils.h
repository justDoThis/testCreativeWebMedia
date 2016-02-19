

/**
 Class EZUtils contains some methods for all project, different functions, such as animations, layers, styles . EZUtils implemented Egor's Zemlyanskiy methods for make developers life more easy
 */
@interface EZUtils : NSObject

+(EZUtils*)instance;

//round views corners
- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color;

//custom colors from hex to rgb
-(CGSize)getHeightOfTexts:(NSString*)text widthOfTextView:(CGFloat)width withFont:(UIFont*)font;
@end

