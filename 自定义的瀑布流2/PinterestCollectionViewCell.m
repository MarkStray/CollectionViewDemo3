//
//  PinterestCollectionViewCell.m
//  CollectionViewDemo3
//
//  Created by user on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import "PinterestCollectionViewCell.h"

@implementation PinterestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor grayColor];
        [self addSubview:self.label];
    }
    return self;
}

- (void)setLabelIndex:(NSInteger)index {
    self.label.text = [NSString stringWithFormat:@"%ld",index];
}

@end
