#import "MyConnectionViewLayout.h"
#define COLUMN_COUNT 3
#define ITEM_WIDTH   120.0
@implementation MyConnectionViewLayout

-(id)init{
    if (self = [super init]) {
        _columnCount = COLUMN_COUNT;
        _itemWidth   = ITEM_WIDTH;
        _sectionInset = UIEdgeInsetsZero;
        
        _attributeArray = [[NSMutableArray alloc]init];
        _itemHeightArray = [[NSMutableArray alloc]init];
        for (int index = 0; index < COLUMN_COUNT; index++) {
            _itemHeightArray[index] = @(0);
        }
    }
    return self;
}

//准备布局，重写这个函数，计算出所有cell 的位置
-(void)prepareLayout{
    [super prepareLayout];
    
    //获取有多少个item也就是cell
   _itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat width = self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right;
    
   _innerSpaceing = (width-COLUMN_COUNT*ITEM_WIDTH)/(COLUMN_COUNT-1);
   
    for (int index = 0; index < _itemCount; index++) {
        //计算每一个item的坐标
        
        //1.获取最小高度所对应的列
        NSInteger colIndex = [self getShorttestColumnIndex];
        
        //计算x坐标
        CGFloat xOffSet = _sectionInset.left + colIndex*ITEM_WIDTH + colIndex*_innerSpaceing;
        //计算y坐标
        CGFloat yOffset = _sectionInset.top + [_itemHeightArray[colIndex] floatValue] + _innerSpaceing;
        //高度随机值
        CGFloat itemHeight = [self.delegate itemHeight:self atIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        //更新对应列的高度
        _itemHeightArray[colIndex] = [NSNumber numberWithFloat:yOffset + itemHeight];
        
        //frame = (x,y,width,height)
        CGRect rect = CGRectMake(xOffSet, yOffset, ITEM_WIDTH, itemHeight);
        
        //注意2 生成方式不能用alloc init
        //UICollectionViewLayoutAttributes *attribute = [[UICollectionViewLayoutAttributes alloc]init];
        
        //记录了cell的位置信息
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        attribute.frame = rect;
        
        //存放所有的item的位置信息，位置信息的使用UICollectionViewLayoutAttributes进行封装
        [_attributeArray addObject:attribute];
    }
}

//计算哪一列最短
-(NSInteger)getShorttestColumnIndex
{
    __block CGFloat shortHeight = MAXFLOAT;
    __block NSInteger index = 0;
    
    //enumerateObjectsUsingBlock 使用block枚举数据，取得数组中最小的值
    [_itemHeightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat idxHeight = [[_itemHeightArray objectAtIndex:idx] floatValue];
        if (shortHeight > idxHeight) {
            shortHeight = idxHeight;
            index = idx;
        }
    }];
    return index;
}

-(NSInteger)getLongestColumIndex
{
    __block CGFloat longestHeight = 0;
    __block NSInteger index = 0;
    
    [_itemHeightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat idxHeight = [[_itemHeightArray objectAtIndex:idx] floatValue];
        if (longestHeight < idxHeight) {
            longestHeight = idxHeight;
            index = idx;
        }
    }];
    return index;
}

//针对每一个NSindexPath对应的item，返回它对应的位置信息
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _attributeArray[[indexPath row]];
    
}

//返回给定rect中包含的item的布局信息（也就是位置信息）
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //注意1 枚举方式
    return [_attributeArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes  *evaluatedObject, NSDictionary *bindings) {
        //判断两个矩形是否有交叉
        return CGRectIntersectsRect(rect, evaluatedObject.frame);
    }]];
}

//计算contentSize，类似于UIScrollView的contentSize，滚动使用
- (CGSize)collectionViewContentSize
{
    NSInteger colIndex = [self getLongestColumIndex];
    return CGSizeMake(self.collectionView.frame.size.width, [_itemHeightArray[colIndex] floatValue]+_innerSpaceing+_sectionInset.bottom);
}

@end
