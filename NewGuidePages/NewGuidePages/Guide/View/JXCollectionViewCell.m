//
//  JXCollectionViewCell.m
//  NewGuidePages
//
//  Created by 白金星 on 15/12/15.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXCollectionViewCell.h"
#define kScreenSize [UIScreen mainScreen].bounds
@interface JXCollectionViewCell ()
@property (nonatomic,weak)UIImageView *imgView;

@end

@implementation JXCollectionViewCell


- (UIImageView *)imgView{

    if (!_imgView) {
        UIImageView  *imagView = [[UIImageView alloc]init];

        imagView.frame = kScreenSize;
        [self addSubview:imagView];
        _imgView = imagView;
    }
    return _imgView;
}

- (void)setImage:(UIImage *)image{

    _image = image;

    //把数据添加到空间上
    self.imgView.image = image;

}
@end
