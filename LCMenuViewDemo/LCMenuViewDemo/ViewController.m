//
//  ViewController.m
//  LCMenuViewDemo
//
//  Created by iWolf on 2021/6/1.
//

#import "ViewController.h"
#import "LCMenuToolView.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)LCMenuToolView * menuToolView;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuToolView];
    
}
-(LCMenuToolView *)menuToolView{
    if (_menuToolView == nil) {
        _menuToolView = [[LCMenuToolView alloc] initWithFrame:CGRectMake(0,(self.view.frame.size.height-100)/2, self.view.frame.size.width, 144)];
        
    }
    return _menuToolView;
}
@end
