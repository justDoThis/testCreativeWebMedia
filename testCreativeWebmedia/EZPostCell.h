

#import "EZPost.h"

@interface EZPostCell : UITableViewCell

+ (UINib *)nib;
- (void)configurateCellWithItem:(EZPost *)item;

@end
