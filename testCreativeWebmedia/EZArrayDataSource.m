
#import "EZArrayDataSource.h"

@interface EZArrayDataSource ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation EZArrayDataSource

- (id)init
{
    return nil;
}

//configure cell for common abstract item
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
    return self;
}

-(void)removeItemsAtIndex:(id)anItem atIndex:(int)index
{
    NSMutableArray * items = [[NSMutableArray alloc]initWithArray:_items];
    [items removeObject:anItem];
    _items = [[NSArray alloc]initWithArray:items];
}

-(void)addItemsAtIndex:(id)anItem atIndex:(int)index
{
    NSMutableArray * items = [[NSMutableArray alloc]initWithArray:_items];
    [items insertObject:anItem atIndex:index];
    _items = [[NSArray alloc]initWithArray:items];
}

//return abstract item at index path
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

@end
