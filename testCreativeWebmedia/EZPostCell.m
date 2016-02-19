

#import "EZPostCell.h"
#import "EZUtils.h"
#import "EZPostsManager.h"

@interface EZPostCell()

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UILabel *rate;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) EZPost *item;

@end

@implementation EZPostCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)configurateCellWithItem:(EZPost *)item;
{
    _title.text = item.title;
    _desc.text = item.desc;
    _author.text = item.author;
    _rate.text = [NSString stringWithFormat:@"Rate : %@",[item getRate]];
    _image.image = [UIImage imageNamed:@"unfill_stub.jpg"];
    
    if(!item.image){
        [[EZPostsManager getSharedInstance]loadPostsPhoto:item.imageUrl callback:^(UIImage *result) {
            item.image = result;
            _image.image = result;
        }];
    }
    else
    {
        _image.image = item.image;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
