//
//  JXGuideController.m
//  NewGuidePages
//
//  Created by 白金星 on 15/12/15.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXGuideController.h"
#import "JXCollectionViewCell.h"
#import "UIView+Frame.h"
#import "JXTabBarController.h"
#define kScreenSize [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface JXGuideController ()

@property (weak, nonatomic) UIImageView* largeImageView;
@property (weak, nonatomic) UIImageView* largeTextView;
@property (weak, nonatomic) UIImageView* smallTextView;

@property (assign, nonatomic) int page;

@end

@implementation JXGuideController

static NSString * const reuseIdentifier = @"Cell";

//重写init方法,创建的适合使用这个布局
- (instancetype)init{

    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    //设置大小
    layout.itemSize = kScreenSize.size;
    //方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //左右间距
    layout.minimumLineSpacing = 0;

    return [super initWithCollectionViewLayout:layout];

}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{

    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //设置单元格
    [self.collectionView registerClass:[JXCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    //取消弹性的效果
    self.collectionView.bounces = NO;
    //分页
    self.collectionView.pagingEnabled = YES;
    //不显示滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;

    //获取大图片名字
    NSString *largeImageName = @"guide1";
    //获取大图
    UIImage *largeImge = [UIImage imageNamed:largeImageName];

    // 获取大文字的名字
    NSString* largeTextName = @"guideLargeText1";
    // 获取大文字图片
    UIImage* largeText = [UIImage imageNamed:largeTextName];
    // 获取小文字的名字
//    NSString* smallTextName = @"guideSmallText1";
    // 获取大文字图片
//    UIImage* smallText = [UIImage imageNamed:smallTextName];

    // imageView
    UIImageView* largeImageView = [[UIImageView alloc] initWithImage:largeImge];
    UIImageView* largeTextView = [[UIImageView alloc] initWithImage:largeText];
      
    largeImageView.w = kScreenHeight * 0.3;
    largeImageView.h = kScreenHeight * 0.45;
    largeTextView.w = kScreenHeight * 0.562;
    largeTextView.h = kScreenHeight * 0.2;
    largeTextView.y = kScreenHeight * 0.68;
//    UIImageView* smallTextView = [[UIImageView alloc] initWithImage:smallText];
//    smallTextView.y = kScreenHeight * 0.85;

    // 给全局属性赋值
    self.largeImageView = largeImageView;
    self.largeTextView = largeTextView;
//    self.smallTextView = smallTextView;

    // 添加三个imageView
    [self.collectionView addSubview:largeImageView];
    [self.collectionView addSubview:largeTextView];
//    [self.collectionView addSubview:smallTextView];

    // 创建一个进入按钮
    UIButton* enterBtn = [[UIButton alloc] init];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
    [enterBtn sizeToFit];
    enterBtn.x = 3 * kScreenWidth + (kScreenWidth - enterBtn.w) * 0.5;
    enterBtn.y = kScreenHeight * 0.89;
    // 监听点击事件
    [enterBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];

    [self.collectionView addSubview:enterBtn];
}

// 点击进入按钮的点击事件
- (void)enter
{
    // 创建tabbarController
    JXTabBarController  *tab = [[JXTabBarController alloc] init];
    // 切换window的根控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

// scrollView 已经减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;

    // 计算页数
    int page = offsetX / kScreenWidth;

    if (page > self.page) {
        // 从右往左滑(手)
        self.largeImageView.x = offsetX + kScreenWidth;
        self.largeTextView.x = offsetX + kScreenWidth;
        self.smallTextView.x = offsetX + kScreenWidth;
    }
    else {
        // 从左往右滑(手)
        self.largeImageView.x = offsetX - kScreenWidth;
        self.largeTextView.x = offsetX - kScreenWidth;
        self.smallTextView.x = offsetX - kScreenWidth;
    }


    // 获取大图片名字
    NSString* largeImageName = [NSString stringWithFormat:@"guide%d", page + 1];
    // 获取大图
    UIImage* largeImage = [UIImage imageNamed:largeImageName];
    // 获取大文字的名字
    NSString* largeTextName = [NSString stringWithFormat:@"guideLargeText%d", page + 1];
    // 获取大文字图片
    UIImage* largeText = [UIImage imageNamed:largeTextName];
    // 获取小文字的名字
    NSString* smallTextName = [NSString stringWithFormat:@"guideSmallText%d", page + 1];
    // 获取大文字图片
    UIImage* smallText = [UIImage imageNamed:smallTextName];

    // 更换图片
    self.largeImageView.image = largeImage;
    self.largeTextView.image = largeText;
    self.smallTextView.image = smallText;

    // 加特技
    [UIView animateWithDuration:0.25
                     animations:^{
                         // 让介绍图片的x改变
                         self.largeImageView.x = offsetX;
                         self.largeTextView.x = offsetX;
                         self.smallTextView.x = offsetX;
                     }];

    // 保存当前的页数
    self.page = page;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
////
//    return 0;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
      //获取数据
    NSString *imageName = [NSString stringWithFormat:@"guide%ldBackground",indexPath.row+1];
    //获取图片
    UIImage *image = [UIImage imageNamed:imageName];
    //把数据传给cell
    cell.image = image;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
