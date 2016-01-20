//
//  LYKDesCell.m
//  cehua
//
//  Created by ws on 16/1/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "LYKDesCell.h"

@implementation LYKDesCell

- (void)setSubView:(UIView *)subView{
    
    _subView = subView;
    subView.frame = self.bounds;
    [self addSubview:subView];
}

@end
