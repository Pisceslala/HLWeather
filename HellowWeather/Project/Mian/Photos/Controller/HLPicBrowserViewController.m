//
//  HLPicBrowserViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/8.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLPicBrowserViewController.h"
#import <UIImageView+WebCache.h>
#import "UIImage+HLUIImage.h"
@interface HLPicBrowserViewController ()

/**
 imageView
 */
@property (strong, nonatomic) UIImageView *imageV;

/**
 滑动
 */
@property (strong, nonatomic) UIScrollView *scrollView;

/**
 原始尺寸
 */
@property (assign, nonatomic) CGSize orinSize;

/**
 是否缩放
 */
@property (assign, nonatomic) BOOL isScale;

@end

@implementation HLPicBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.imageV];
    
    //配置手势
    [self configGestureRecognizer];
    
    
    self.isScale = YES;
}

//点击缩放图片
- (void)ClickToscaleImage {
    //指定宽度缩放
    UIImage *newImage = [[UIImage alloc] imageCompressForWidthScale:self.imageV.image targetWidth:SSScreenW];
    
    //判断当前缩放状态
    if (self.isScale) {
        self.imageV.JYD_Size = self.orinSize;
        self.imageV.JYD_Y = 0;
        self.scrollView.contentSize = self.orinSize;
        self.scrollView.scrollEnabled = YES;
    }else {
        self.imageV.JYD_Size = newImage.size;
        self.imageV.JYD_Y = SSScreenH / 2 - (self.imageV.JYD_Height / 2);
        self.scrollView.contentSize = newImage.size;
        self.scrollView.scrollEnabled = NO;
    }
    
    //状态取反
    self.isScale = !self.isScale;
    
}

- (void)ClickToSaveImage: (UILongPressGestureRecognizer *)press {
    if (press.state == UIGestureRecognizerStateBegan) {
        if (self.isScale) {
            [AlertControllerTool alertShootActionAtTitle:@"保存图片" message:@"是否将图片保存至相册" sureTitle:@"确定" cancelTitle:@"取消" confirmHandler:^(UIAlertAction *action) {
                //保存图片到相册
                UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinshSavingWithError:contextInfo:),nil);
                
            } cancelHandler:^(UIAlertAction *action) {
                
            }];
        }
    }
}

-(void)image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"save success!"];
    }else {
        [SVProgressHUD showErrorWithStatus:@"save failed!"];
    }
}

- (void)configGestureRecognizer {
    //单击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToscaleImage)];
    [self.scrollView addGestureRecognizer:tap];
    
    //长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToSaveImage:)];
    longPress.minimumPressDuration = 0.3f;
    [self.scrollView addGestureRecognizer:longPress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (UIImageView *)imageV {
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.backgroundColor = [UIColor lightGrayColor];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.regularURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            UIImage *newImage = [[UIImage alloc] imageCompressForWidthScale:image targetWidth:SSScreenW];
            imageV.JYD_X = 0;
            imageV.JYD_Size = newImage.size;
            imageV.JYD_Y = SSScreenH / 2 - (imageV.JYD_Height / 2);
            self.orinSize = image.size;
            self.scrollView.contentSize = newImage.size;
        }];

        _imageV = imageV;
        
        
    }
    return _imageV;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SSScreenW, SSScreenH)];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
        sc.bounces = NO;
        _scrollView = sc;
    }
    return _scrollView;
}

#pragma mark - set
- (void)setFullURL:(NSString *)fullURL {
    _fullURL = fullURL;
}

- (void)setThumbURL:(NSString *)regularURL {
    _regularURL = regularURL;
}

@end
