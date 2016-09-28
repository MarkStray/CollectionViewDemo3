//
//  PinterestCollectionViewLayout.h
//  CollectionViewDemo3
//
//  Created by user on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinterestCollectionViewLayout : UICollectionViewLayout

@property(nonatomic)NSInteger    itemCount;    //cell个数
@property(nonatomic)NSUInteger   columnCount;  //多少列
@property(nonatomic)CGFloat      itemWidth;    //cell 宽度
@property(nonatomic)UIEdgeInsets sectionInset; //留白
@property(nonatomic)CGFloat      innerSpaceing;//cell之间的间距


@property(nonatomic)NSMutableArray *itemHeightArray;//记录每列当前布局的高度
@property(nonatomic)NSMutableArray *attributeArray;//属性数组

@end
