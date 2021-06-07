//
//  LCMenuTitleCell.m
//  LCMenuViewDemo
//
//  Created by iWolf on 2021/6/1.
//

#import "LCMenuTitleCell.h"

@implementation LCMenuTitleCell

#pragma mark - 1.Setting View and Style
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.titleLabel];
        [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}


#pragma mark - 2.Custom Methods


-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (isSelect) {
        _titleLabel.textColor =  [UIColor yellowColor];
    }else{
        _titleLabel.textColor = [UIColor whiteColor];
    }

}

#pragma mark - 3.Set & Get

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
@end
