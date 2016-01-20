//
//  LYKTopCell.m
//  cehua
//
//  Created by ws on 16/1/4.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "LYKTopCell.h"


@implementation LYKTopCellModel

@end


@interface LYKTopCell (){
    
    UILabel *_titleLabel;
    UILabel *_bottomLine;
}

@end


@implementation LYKTopCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpContent];

    }
    return self;
}

- (void)setUpContent{
    
    /**
     *  标题
     */
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    /**
     *  下边的横条
     */
    _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 2)];
    _bottomLine.backgroundColor = [UIColor blueColor];
    [self addSubview:_bottomLine];
}

- (void)setCellModel:(LYKTopCellModel *)cellModel{
    
    _cellModel = cellModel;
    _titleLabel.text = cellModel.titleText;
    _titleLabel.textColor = cellModel.titleColor;
    if (_titleLabel.textColor == [UIColor blueColor]) {
        _bottomLine.hidden = NO;
    }else{
        
        _bottomLine.hidden = YES;
    }

    
    

    
    
}

@end
