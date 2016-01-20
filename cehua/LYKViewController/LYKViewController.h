//
//  LYKViewController.h
//  cehua
//
//  Created by ws on 16/1/4.
//  Copyright © 2016年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYKViewController;

@protocol LYKViewControllerDesCollectionDataSouce <NSObject>
/**
 *  下方collection的代理和数据源
 */
@required
- (NSArray *)LYKViewControllerForDesView:(LYKViewController *)viewController;


/**
 *  上方collection的代理和数据源方法
 */
- (NSArray *)LYKViewControllerForTopArr:(LYKViewController *)viewController;

@end


@protocol LYKViewControllerDesCollectionDelegate <NSObject>

@optional
/**
 *  滚动到了哪个位置，在每次滚动的时候调用
 */
- (void)LYKViewController:(LYKViewController *)viewController ScrollToIndex:(NSIndexPath *)indexPath;

@end


@interface LYKViewController : UIViewController

@property (nonatomic, weak) id<LYKViewControllerDesCollectionDataSouce> DataSouce;
@property (nonatomic, weak) id<LYKViewControllerDesCollectionDelegate> delegate;


@end
