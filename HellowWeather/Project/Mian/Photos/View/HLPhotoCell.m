//
//  HLPhotoCell.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/7.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLPhotoCell.h"
#import <UIImageView+WebCache.h>
#import "HLPhotosModel.h"
@interface HLPhotoCell ()


@end

@implementation HLPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HLPhotosModel *)model {
    _model = model;
    

    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.regular] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 5;
    frame.origin.x += 5;
    frame.size.height -= 5;
    frame.size.width -= 10;
    [super setFrame:frame];
}

@end
