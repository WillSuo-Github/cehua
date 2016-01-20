//
//  viewController.m
//  cehua
//
//  Created by ws on 16/1/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "viewController.h"
#import "LYKViewController.h"

#define lykSreenWidth [UIScreen mainScreen].bounds.size.width
#define lykSreenHeight [UIScreen mainScreen].bounds.size.height
#define RandomCOLOR [UIColor colorWithRed:arc4random() % 255/255.0f green:arc4random() % 255/255.0f blue:arc4random() % 255/255.0f alpha:1]

@interface viewController ()<LYKViewControllerDesCollectionDataSouce,LYKViewControllerDesCollectionDelegate>

@property (nonatomic, strong) LYKViewController *lykVC;

@end


@implementation viewController

- (void)viewDidLoad{
    

    
    [super viewDidLoad];
    LYKViewController *lykVC = [[LYKViewController alloc] init];
    self.lykVC = lykVC;
    lykVC.DataSouce = self;
    lykVC.delegate = self;
    lykVC.view.frame = CGRectMake(0, 20, lykSreenWidth, lykSreenHeight);
    [self.view addSubview:lykVC.view];
    
    
    
    
}



#pragma mark - 数据源方法
- (NSArray *)LYKViewControllerForDesView:(LYKViewController *)viewController{
    
    UIColor *color1 = [UIColor redColor];
    UIColor *color2 = [UIColor blackColor];
    UIColor *color3 = [UIColor grayColor];
    UIColor *color4 = [UIColor greenColor];
    UIColor *color5 = [UIColor purpleColor];
    UIColor *color6 = [UIColor orangeColor];
    UIColor *color7 = [UIColor blueColor];
    UIColor *color8 = [UIColor lightTextColor];
    UIColor *color9 = [UIColor lightGrayColor];
    
    
    NSArray *arr = @[color1,color2,color3,color4,color5,color6,color7,color8,color9];
    
    NSMutableArray *viewArr = [NSMutableArray array];
    for (int i = 0; i < 9; ++i) {
        UIView *view = [[UIView alloc] init];
//        NSLog(@"color:---%@",arr[i]);
        view.backgroundColor = arr[i];
        [viewArr addObject:view];
    }

    return viewArr;
}

- (NSArray *)LYKViewControllerForTopArr:(LYKViewController *)viewController{
    
    return @[@"恐怖",@"言情",@"欧美",@"动作",@"科幻",@"穿越",@"偶像",@"电视剧",@"电视台"];
}


#pragma mark - 代理方法
- (void)LYKViewController:(LYKViewController *)viewController ScrollToIndex:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",indexPath);
}

@end
