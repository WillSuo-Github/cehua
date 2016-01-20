//
//  LYKTopCell.h
//  cehua
//
//  Created by ws on 16/1/4.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYKTopCellModel : NSObject

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UIColor *titleColor;

@end

@interface LYKTopCell : UICollectionViewCell


@property (nonatomic, strong) LYKTopCellModel *cellModel;


@end
