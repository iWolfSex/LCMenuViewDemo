//
//  LCMenuView.m
//  LCMenuViewDemo
//
//  Created by iWolf on 2021/6/1.
//

#import "LCMenuView.h"

#import "LCMenuCell.h"
static NSString * iconCellID = @"LCMenuCell";
@interface LCMenuView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LCMenuView

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView              = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100) collectionViewLayout:layout];
        _collectionView.delegate     = self;
        _collectionView.dataSource   = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[LCMenuCell class] forCellWithReuseIdentifier:iconCellID];
    }
    return _collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate*, UICollectionViewDataSource*

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LCMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iconCellID forIndexPath:indexPath];
    return cell;
   
}

//这个也是最重要的方法 获取Header的 方法。


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100,100);
  
}
#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10,10,10,10);
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}


#pragma mark - Public Methods

@end
