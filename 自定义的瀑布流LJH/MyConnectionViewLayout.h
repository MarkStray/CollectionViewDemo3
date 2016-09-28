#import <UIKit/UIKit.h>
@class MyConnectionViewLayout;

@protocol MyCollectionLayoutDelegate <NSObject>

-(CGFloat)itemHeight:(MyConnectionViewLayout*)layout atIndexPath:(NSIndexPath*)indexPath;

@end

@interface MyConnectionViewLayout : UICollectionViewLayout

@property(nonatomic)NSInteger    itemCount;    //cell个数
@property(nonatomic)NSUInteger   columnCount;  //多少列
@property(nonatomic)CGFloat      itemWidth;    //cell 宽度
@property(nonatomic)UIEdgeInsets sectionInset; //留白
@property(nonatomic)CGFloat      innerSpaceing;//cell之间的间距


@property(nonatomic)NSMutableArray *itemHeightArray;//记录每列当前布局的高度
@property(nonatomic)NSMutableArray *attributeArray;

@property(nonatomic,weak)id<MyCollectionLayoutDelegate> delegate;

@end
