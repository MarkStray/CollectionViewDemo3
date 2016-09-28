//
//  ViewController.m
//  CollectionViewDemo3
//
//  Created by user on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ViewController.h"

#import "PinterestCollectionViewCell.h"

#import "PinterestCollectionViewLayout.h"

#import "UICollectionViewWaterfallLayout.h"

#import "MyConnectionViewLayout.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterfallLayout,MyCollectionLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 内部有高度随机函数
    PinterestCollectionViewLayout *pinterestLayout = [[PinterestCollectionViewLayout alloc] init];
    pinterestLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.collectionView setCollectionViewLayout:pinterestLayout];
    
    
//    UICollectionViewWaterfallLayout *waterfallLayout = [[UICollectionViewWaterfallLayout alloc] init];
//    waterfallLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//    waterfallLayout.delegate = self;
//    [self.collectionView setCollectionViewLayout:waterfallLayout];

//    MyConnectionViewLayout *mylayout = [[MyConnectionViewLayout alloc]init];
//    mylayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//    mylayout.delegate = self;
//    [self.collectionView setCollectionViewLayout:mylayout];

    
    [self.collectionView registerClass:[PinterestCollectionViewCell class] forCellWithReuseIdentifier:@"PINTERESTCELL"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PinterestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PINTERESTCELL" forIndexPath:indexPath];
    [cell setLabelIndex:indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateWaterfallLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return arc4random()%100*2+100;
}


#pragma mark - MyConnectionViewLayout
-(CGFloat)itemHeight:(MyConnectionViewLayout *)layout atIndexPath:(NSIndexPath *)indexPath {
    return arc4random()%100*2+100;
}

@end
