//
//  HLDetailViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/5.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLDetailViewController.h"
#import "HLDismissAnimator.h"
#import <MJExtension.h>
#import "HLWeatherModel.h"
#import "HLDetailCell.h"
@interface HLDetailViewController ()<UIViewControllerTransitioningDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *detArray;

@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation HLDetailViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    [self.view resignFirstResponder];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HLDetailCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HLDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.itemLabel.text = self.detArray[indexPath.row];
    
    cell.itemImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    
    return cell;
}


#pragma mark - dismissController
- (void)dissmissVCEvent {
    self.transitioningDelegate = self;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HLDismissAnimator new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - set
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    for (HLWeatherModel *model in dataArray) {
        [self.detArray addObject:model.coldIndex];
        [self.detArray addObject:model.dressingIndex];
        [self.detArray addObject:model.exerciseIndex];
        [self.detArray addObject:model.sunrise];
        [self.detArray addObject:model.sunset];
        [self.detArray addObject:model.wind];
    }
    [self.collectionView reloadData];
}

#pragma mark - get
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSScreenW / 3.0, (SSScreenH / 2.0 / 2.0) - 10 );
        layout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, SSScreenH / 2.0) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        //添加手势
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissVCEvent)];
        swip.direction = UISwipeGestureRecognizerDirectionDown;
        [collectionView addGestureRecognizer:swip];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRed:245/255.0 green:36/255.0 blue:67/255.0 alpha:1];
        lineView.JYD_CenterY = 2.5;
        lineView.JYD_CenterX = collectionView.JYD_CenterX - 10;
        lineView.JYD_Width = 40;
        lineView.JYD_Height = 5;
        lineView.layer.masksToBounds = YES;
        lineView.layer.cornerRadius = 3;
        [collectionView addSubview:lineView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissVCEvent)];
        [lineView addGestureRecognizer:tap];
        [collectionView addGestureRecognizer:tap];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (NSMutableArray *)detArray {
    if (_detArray == nil) {
        _detArray = [NSMutableArray array];
    }
    return _detArray;
}

- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"感冒指数",@"穿衣指数",@"户外运动指数",@"日出",@"moon",@"风力"];
    }
    return _imageArray;
}

- (void)dealloc {
    NSLog(@"面板销毁");
}
@end
