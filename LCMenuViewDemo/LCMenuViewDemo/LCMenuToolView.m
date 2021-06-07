//
//  LCMenuToolView.m
//  LCMenuViewDemo
//
//  Created by iWolf on 2021/6/1.
//

#import "LCMenuToolView.h"
#import "LCMenuView.h"
#import "LCMenuTitleCell.h"

static NSString * titleCellID = @"LCMenuTitleCell";

@interface LCMenuToolView()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) LCMenuView * aMenuView;
@property (nonatomic, strong) LCMenuView * bMenuView;
@property (nonatomic, strong) LCMenuView * cMmenuView;

@property(nonatomic, strong)NSMutableArray      *titleDataArray;
@property(nonatomic, strong)UICollectionView    * titleCollectionView;
@property(nonatomic, assign)float               titleItemWidth;
@property(nonatomic, strong)NSString * selectPage;
@property(nonatomic, strong)NSIndexPath         * selectTitleIndexPath;

@end

@implementation LCMenuToolView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.selectTitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self addSubview:self.titleCollectionView];
        self.titleDataArray = [[NSMutableArray alloc] initWithArray: @[@"第一页",@"第二页",@"第三页"]];
        
        [self.selectPage addObserver:self forKeyPath:@"selectPage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

        
        _mainScrollView = ({
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, 100) ];
            scrollView.pagingEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.delegate = self;
            scrollView;
        });
        [self addSubview:_mainScrollView];
        [self.mainScrollView setContentSize:CGSizeMake(frame.size.width *3, 100)];
        [self.mainScrollView addSubview:self.aMenuView];
        self.aMenuView.dataArray = [[NSMutableArray alloc] initWithArray: @[@"",@"",@"",@"",@"",@"",@"",@"",@"",]];
        [self.mainScrollView addSubview:self.bMenuView];
        self.bMenuView.dataArray = [[NSMutableArray alloc] initWithArray: @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
        [self.mainScrollView addSubview:self.cMmenuView];
        self.cMmenuView.dataArray = [[NSMutableArray alloc] initWithArray: @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
        
        
        
        
    }
    return self;
}

-(void)setTitleDataArray:(NSMutableArray *)titleDataArray{
    _titleDataArray = titleDataArray;
    [self.titleCollectionView reloadData];
}


#pragma mark - 5.DataSource and Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.titleDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCMenuTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:titleCellID forIndexPath:indexPath];
    NSString * title = [self.titleDataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = title;
    if (self.selectTitleIndexPath.row == indexPath.row) {
        cell.isSelect = YES;
    }else{
        cell.isSelect = NO;
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self selectScrollViewWithIndex:indexPath.row];
    
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
}


#pragma mark   定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



#pragma mark    定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //设置item的大小
    return CGSizeMake(self.titleItemWidth, 44);
}

#pragma mark - 5.DataSource and Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.mainScrollView.frame.size.width;
    int page = floor((self.mainScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.selectPage setValue:@(page) forKey:@"selectPage"];
    
    self.selectTitleIndexPath = [NSIndexPath indexPathForRow:page inSection:0];
    [self.titleCollectionView reloadData];
    
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    // 通常为以下的写法
       if (object == self.selectPage && [keyPath isEqualToString:@"selectPage"]) {
           // 做些什么...
           NSInteger page = [object integerValue];
           self.selectTitleIndexPath = [NSIndexPath indexPathForRow:0 inSection:page];
           
           self.selectTitleIndexPath = object;
           
           
           NSLog(@"滑动到第%ld",(long)self.selectTitleIndexPath.row);
           [self.titleCollectionView reloadData];
       }
    
    
}

-(void)selectScrollViewWithIndex:(NSInteger)index{
    
    CGFloat imageW = self.mainScrollView .frame.size.width;
    CGPoint position = CGPointMake(index*imageW, 0);
    [self.mainScrollView setContentOffset:position animated:YES];
    
    
}



-(LCMenuView *)aMenuView{
    if (_aMenuView == nil) {
        _aMenuView = [[LCMenuView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _aMenuView.backgroundColor = [UIColor redColor];
    }
    return _aMenuView;
}
-(LCMenuView *)bMenuView{
    if (_bMenuView == nil) {
        _bMenuView = [[LCMenuView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, 100)];
        _bMenuView.backgroundColor = [UIColor yellowColor];
    }
    return _bMenuView;
}

-(LCMenuView *)cMmenuView{
    if (_cMmenuView == nil) {
        _cMmenuView = [[LCMenuView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, 100)];
        _cMmenuView.backgroundColor = [UIColor greenColor];
    }
    return _cMmenuView;
}

-(UICollectionView *)titleCollectionView{
    if (_titleCollectionView == nil) {
        UICollectionViewFlowLayout *titleFlowLayout = [[UICollectionViewFlowLayout alloc] init];
         //行与行间的距离
        titleFlowLayout.minimumLineSpacing = 0;
         //列与列间的距离
        titleFlowLayout.minimumInteritemSpacing = 0;
         //设置item的大小
        self.titleItemWidth = 58;
        titleFlowLayout.itemSize = CGSizeMake(self.titleItemWidth,93);
         //边界值
        titleFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,44) collectionViewLayout:titleFlowLayout];
         // 设置UICollectionView为横向滚动
        [_titleCollectionView setBackgroundColor:[UIColor blackColor]];
        titleFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView.showsVerticalScrollIndicator = NO;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
         //竖直滚动
        _titleCollectionView.delegate=self;
        _titleCollectionView.dataSource=self;
         //注册Cell
        [self.titleCollectionView registerClass:[LCMenuTitleCell class] forCellWithReuseIdentifier:titleCellID];
        [self addSubview:self.titleCollectionView];
        [self.titleCollectionView reloadData];
    }
    return _titleCollectionView;
}

@end
