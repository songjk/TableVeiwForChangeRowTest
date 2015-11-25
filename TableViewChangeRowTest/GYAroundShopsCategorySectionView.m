//
//  GYAroundShopsCategorySectionView.m
//  HSConsumer
//
//  Created by Apple03 on 15/11/20.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import "GYAroundShopsCategorySectionView.h"
#import "GYAroundShopsCategoryButton.h"
#import "GYAroundShopsCategoryModel.h"

@interface GYAroundShopsCategorySectionView()
@property (nonatomic,weak) UILabel *lbTitle;
@property (nonatomic,weak) GYAroundShopsCategoryButton * btnChoose;
@property (nonatomic,weak) GYAroundShopsCategoryButton * btnShowAll;
@property (nonatomic,weak) UIImageView * imvArrow;
@end


@implementation GYAroundShopsCategorySectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat btnWidth = kScreenWidth - 140;
    CGFloat btnHeight = self.frame.size.height;
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, btnWidth, btnHeight)];
    lbTitle.textColor = [UIColor greenColor];
    lbTitle.contentMode = UIViewContentModeCenter;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.font = [UIFont systemFontOfSize:17];
    lbTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:lbTitle];
    self.lbTitle = lbTitle;
    
    GYAroundShopsCategoryButton * btnChoose = [GYAroundShopsCategoryButton buttonWithType:UIButtonTypeCustom];
    btnChoose.backgroundColor = [UIColor clearColor];
    btnChoose.frame = lbTitle.frame;
    [btnChoose addTarget:self action:@selector(chooseSection:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnChoose];
    
    GYAroundShopsCategoryButton * btnShowAll = [GYAroundShopsCategoryButton buttonWithType:UIButtonTypeCustom];
    btnShowAll.backgroundColor = [UIColor clearColor];
    [btnShowAll setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btnShowAll.titleLabel.font = [UIFont systemFontOfSize:13];
    btnShowAll.frame = CGRectMake(CGRectGetMaxX(lbTitle.frame), 0, kScreenWidth - btnWidth, btnHeight);
    [btnShowAll addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnShowAll];
    self.btnShowAll = btnShowAll;
    
    UIImageView * imvArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ep_cell_btn_right_arrow.png"]];
    CGFloat imvWidth = 12;
    CGFloat imvHeight = 20;
    imvArrow.frame = CGRectMake(kScreenWidth - imvWidth - 20, 0, imvWidth, imvHeight);
    imvArrow.center = CGPointMake(imvArrow.center.x, btnShowAll.center.y);
    [self addSubview:imvArrow];
    self.imvArrow = imvArrow;
}
-(void)chooseSection:(GYAroundShopsCategoryButton *)sender
{
    NSLog(@"choose section %zi",self.index);
    self.chooseBlock(self.index);
}
-(void)showAll:(GYAroundShopsCategoryButton *)sender
{
    NSLog(@"showAll section %zi",self.index);
    self.ShowBlock(self.index);
}
-(void)setViewWithData:(GYAroundShopsCategoryModel *)model
{
    self.categoryModel = model;
    if ([model.categoryName hasPrefix:@"全部"])
    {
        self.imvArrow.hidden = NO;
        [self.btnShowAll setTitle:@"" forState:UIControlStateNormal];
        self.lbTitle.text=@"";
        self.lbTitle.text = model.categoryName;
    }
    else
    {
        self.imvArrow.hidden = YES;
        [self.btnShowAll setTitle:@"查看全部" forState:UIControlStateNormal];
        self.lbTitle.text = model.categoryName;
    }
}
@end
