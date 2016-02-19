

#import "EZPostsViewController.h"
#import "EZArrayDataSource.h"
#import "EZPostCell.h"
#import "EZPostsManager.h"
#import "EZUtils.h"
#import "EZPost.h"

#import "EZDetailPostViewController.h"

//statics variables for class
static NSString * const kPostCellIdentifier = @"kPostCellIdentifier";
static NSString * const kDetailVC = @"EZDetailPostViewController";
static NSString * const kToDetailVCSeg = @"toDetailVC";

static int kSizeOfCell = 310;

@interface EZPostsViewController ()<UITableViewDelegate>

@property (nonatomic, copy  ) NSMutableArray * posts;
@property (nonatomic, strong) IBOutlet UITableView * postsTable;
@property (nonatomic, strong) EZArrayDataSource * postsDataSources;

@end

@implementation EZPostsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Posts";
    
    [self loadNews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getPosts
{
    [[EZPostsManager getSharedInstance]loadPosts:^(NSArray *result) {
        _posts = [[NSMutableArray alloc]initWithArray:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupTableViewWithPosts];
        });
    }];
}

-(void)loadNews
{
    _posts = [[NSMutableArray alloc]init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        [self getPosts];
    });
}

//setup table view with messages
- (void)setupTableViewWithPosts
{
    //configure call with unique identifier
    TableViewCellConfigureBlock configureCell = ^(EZPostCell *cell, EZPost *item) {
        [cell configurateCellWithItem:item];
    };
    
    //creating datasource for tableview
    _postsDataSources = [[EZArrayDataSource alloc] initWithItems:_posts cellIdentifier:kPostCellIdentifier configureCellBlock:configureCell];
    
    //registering the nib and reload tableView
    _postsTable.dataSource = _postsDataSources;
    _postsTable.delegate = self;
    [_postsTable registerNib:[EZPostCell nib] forCellReuseIdentifier:kPostCellIdentifier];
    [_postsTable reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EZPost* v = _posts[indexPath.row];
    return [[EZUtils instance]getHeightOfTexts:[NSString stringWithFormat:@"%@ \n %@ \n %@ ",v.title,v.author,v.rate] widthOfTextView:_postsTable.frame.size.width-100 withFont:[UIFont fontWithName:@"Helvetica" size:17]].height+kSizeOfCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kToDetailVCSeg sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EZDetailPostViewController *detailVC = [segue destinationViewController];
    // invoked from table view cell selection
    NSIndexPath *indexPath = [_postsTable indexPathForSelectedRow];
    [_postsTable deselectRowAtIndexPath:indexPath animated:YES];
    [detailVC setupPost:_posts[indexPath.row]];
}

@end
