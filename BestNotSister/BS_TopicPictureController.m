//
//  BS_TopicPictureController.m
//  BestNotSister
//
//  Created by huhang on 16/3/30.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TopicPictureController.h"
#import "BS_ProgressView.h"
#import "BS_Topic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@interface BS_TopicPictureController ()

/** 进度条 */
@property (weak, nonatomic) IBOutlet BS_ProgressView *progressView;

/** 滑动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** 图片视图 */
@property (weak, nonatomic)UIImageView *imageView;

//转发按钮
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
//保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation BS_TopicPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //转发按钮
    self.repostBtn.layer.borderWidth = 1;
    self.repostBtn.layer.borderColor = [UIColor grayColor].CGColor;
    //保存按钮
    self.saveBtn.layer.borderWidth = 1;
    self.saveBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    //创建图片视图
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    [self showImageView];
}

#pragma mark 展示图片
- (void)showImageView{
    
    //调整尺寸
    CGFloat pictureW = SCREEN_WIDTH;
    CGFloat pictureH = pictureW * (self.pictureModel.height / self.pictureModel.width);
    if (pictureH >= SCREEN_HEIGHT) {//需要滚动
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        self.imageView.size = CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = SCREEN_HEIGHT * 0.5;
    }
    
    //马上显示下载进度
    [self.progressView setProgress:self.pictureModel.pictureProgress animated:YES];
    
    //下载图片
    NSURL *imgUrl = [NSURL URLWithString:self.pictureModel.large_imageUrl];
    [self.imageView sd_setImageWithURL:imgUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //进度时时值
        CGFloat progrss = 1.0 * receivedSize / expectedSize;
        //显示下载进度
        [self.progressView setProgress:progrss animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片下载完成隐藏进度视图
        self.progressView.hidden = YES;
    }];
}

#pragma mark 保存图片
- (IBAction)savePicture:(id)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还未下载完成"];
        return;
    }
    //保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contexts:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contexts:(NSString *)context{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存图片成功"];
    }
}

//返回
- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//转发
- (IBAction)respostPicture:(id)sender {
    NSLog(@"需要登录才可以使用");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
