
typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface EZArrayDataSource : NSObject <UITableViewDataSource>

//configure cell for common abstract item
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

-(void)addItemsAtIndex:(id)anItem atIndex:(int)index;
-(void)removeItemsAtIndex:(id)anItem atIndex:(int)index;

//get abstract item at index path
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end