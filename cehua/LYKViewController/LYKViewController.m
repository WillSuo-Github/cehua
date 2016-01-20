//
//  LYKViewController.m
//  cehua
//
//  Created by ws on 16/1/4.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "LYKViewController.h"

#import "LYKTopCell.h"
#import "LYKDesCell.h"
#import "LYKViewExt.h"

#define topCollectionTag 598678769874521//区分两个collection的tag
#define desCollectionTag 943523466234512//区分两个collection的tag
#define canSeeCount 4  //代表当前界面能够看到的item个数
#define topCellID @"TOPCELLID"
#define desCellID @"desCellID"


@interface LYKViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *topCollection;//顶部的collection
@property (nonatomic, strong) UICollectionView *desCollection;//详情的collection

@property (nonatomic, strong) NSMutableArray *topArr;//保存上方collection的模型数据
@property (nonatomic, strong) NSArray *topPathArr;//保存上方collection可视范围的数组
@property (nonatomic, assign) NSInteger topSelectIndex;//保存上方collection选中的index





@end


@implementation LYKViewController



- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setUpSubViews];
    
    [self transitionTopArr];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0
];
    [self collectionView:self.topCollection didSelectItemAtIndexPath:indexPath];
}


- (void)setUpSubViews{
    
    /**
     顶部的collection
     */
    UICollectionViewFlowLayout *topLayout = [[UICollectionViewFlowLayout alloc] init];
    [topLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [topLayout setMinimumInteritemSpacing:0];
    [topLayout setMinimumLineSpacing:0];
    UICollectionView *topCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40) collectionViewLayout:topLayout];
    self.topCollection = topCollection;
    topCollection.backgroundColor = [UIColor whiteColor];
    [topCollection registerClass:[LYKTopCell class] forCellWithReuseIdentifier:topCellID];
    topCollection.dataSource = self;
    topCollection.delegate = self;

    [self.view addSubview:topCollection];
    
    /**
     *  下边的collection
     */
    UICollectionViewFlowLayout *desLayout = [[UICollectionViewFlowLayout alloc] init];
    [desLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [desLayout setMinimumInteritemSpacing:0];
    [desLayout setMinimumLineSpacing:0];
    UICollectionView *desCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 40) collectionViewLayout:desLayout];
    self.desCollection = desCollection;
    desCollection.backgroundColor = [UIColor lightGrayColor];
    [desCollection registerClass:[LYKDesCell class] forCellWithReuseIdentifier:desCellID];
    desCollection.dataSource = self;
    desCollection.delegate = self;
    desCollection.scrollEnabled = NO;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
//    [desCollection addGestureRecognizer:pan];
    UISwipeGestureRecognizer *leftSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [leftSwip setDirection:UISwipeGestureRecognizerDirectionLeft];
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [rightSwip setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [desCollection addGestureRecognizer:rightSwip];
    [desCollection addGestureRecognizer:leftSwip];
    
//    desCollection.pagingEnabled = YES;
    [self.view addSubview:desCollection];
}
/**
 *  把传递过来的上方collection的数据源arr，转换成对象的arr，使得对象的能带着颜色的区分状态
 */
- (void)transitionTopArr{
    
    NSArray *arr = [self.DataSouce LYKViewControllerForTopArr:self];
    NSMutableArray *tmp = [NSMutableArray array];
    for (NSString *title in arr) {
        LYKTopCellModel *model = [[LYKTopCellModel alloc] init];
        model.titleText = title;
        model.titleColor = [UIColor blackColor];
        [tmp addObject:model];
    }
    self.topArr = tmp;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.topArr.count;
}




// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == self.topCollection) {
        LYKTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellID forIndexPath:indexPath];

        
        cell.cellModel = self.topArr[indexPath.row];
        return cell;
    }else{
        
        LYKDesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:desCellID forIndexPath:indexPath];
        NSArray *arr = [self.DataSouce LYKViewControllerForDesView:self];
        UIView *view = arr[indexPath.row];

//        CGRect frame = view.frame;
//        frame = self.desCollection.bounds;
//        view.frame = frame;
//        [cell.contentView addSubview:view];
        cell.subView = view;
        return cell;
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.topCollection) {
        
        return CGSizeMake(self.view.width / canSeeCount, self.topCollection.frame.size.height);
    }else{
        
        return CGSizeMake(self.view.width, self.view.height - self.topCollection.height);
    }
   
}



#pragma mark - collection的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.topCollection) {
        
        for (LYKTopCellModel *m in self.topArr) {
            m.titleColor = [UIColor blackColor];
        }
        LYKTopCellModel *model = self.topArr[indexPath.row];
        model.titleColor = [UIColor blueColor];
        [self.topCollection reloadData];
        self.topSelectIndex = indexPath.row;
        /**
         *  准备切换第二个collection
         */
        [self.desCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        /**
         *  代理出去滚动到了什么状态
         */
        if ([self.delegate respondsToSelector:@selector(LYKViewController:ScrollToIndex:)]) {
            [self.delegate LYKViewController:self ScrollToIndex:indexPath];
        }
    }

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.desCollection) {
        
        NSIndexPath *desPath = [[self.desCollection indexPathsForVisibleItems] firstObject];
        [self.topCollection selectItemAtIndexPath:desPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        [self collectionView:self.topCollection didSelectItemAtIndexPath:desPath];
//        self.topPathArr = [self.topCollection indexPathsForVisibleItems];
    }
    
}




#pragma mark - 手势的方法
- (void)panGestureAction:(UISwipeGestureRecognizer *)pan{
    
    NSInteger index;
    NSIndexPath *path;
    if (pan.direction == UISwipeGestureRecognizerDirectionRight) {//向右

        index = self.topSelectIndex - 1;
        if (index <= 0) {
            index = 0;
        }
        path = [NSIndexPath indexPathForRow:index inSection:0];
        [self collectionView:self.topCollection didSelectItemAtIndexPath:path];
        
    }else if(pan.direction == UISwipeGestureRecognizerDirectionLeft){//向左

        index = self.topSelectIndex + 1;
        if (index >= self.topArr.count - 1) {
            index = self.topArr.count - 1;
        }
        path = [NSIndexPath indexPathForRow:index inSection:0];
        [self collectionView:self.topCollection didSelectItemAtIndexPath:path];

    }
    
    [self.topCollection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}




@end
