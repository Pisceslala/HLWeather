//
//  HLPhotoCell.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/7.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLPhotoCell.h"
#import "HLPhotosModel.h"
@interface HLPhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation HLPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HLPhotosModel *)model {
    _model = model;
    
    
}

@end
