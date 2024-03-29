//
//  GYAroundShopsCategoryCell.m
//  HSConsumer
//
//  Created by Apple03 on 15/11/20.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import "GYAroundShopsCategoryCell.h"
#import "GYAroundShopsCategoryButton.h"
#import "GYAroundShopsCategoryModel.h"
#import "UIView+CustomBorder.h"
#define btnCount 3
#define btnWidth kScreenWidth/btnCount

@interface GYAroundShopsCategoryCell ()
@end


@implementation GYAroundShopsCategoryCell

- (void)awakeFromNib {
}
+(instancetype)cellWithTableVeiw:(UITableView *)tableView
{
    GYAroundShopsCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:KAroundShopsCategoryCell];
    if (!cell) {
        cell = [[GYAroundShopsCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KAroundShopsCategoryCell];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<btnCount; i++) {
        GYAroundShopsCategoryButton * btn = [GYAroundShopsCategoryButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, 44);
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.index= i;
        [btn addAllBorder];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}
-(void)clicked:(GYAroundShopsCategoryButton*)sender
{
    NSLog(@"clicked");
    if (sender.currentTitle.length>0) {
        if ([self.delegate respondsToSelector:@selector(AroundShopsCategoryCellDidChooseItemWith:index:)]) {
            [self.delegate AroundShopsCategoryCellDidChooseItemWith:self.indexP index:sender.index];
        }
    }
}
-(void)setCellDetailWithArray:(NSArray *)arryData
{
    for (UIView *view in self.contentView.subviews)
    {
        if ([view isKindOfClass:[GYAroundShopsCategoryButton class]]) {
            GYAroundShopsCategoryButton * btn = (GYAroundShopsCategoryButton*)view;
            [btn setTitle:@"" forState:UIControlStateNormal];
        }
    }
    for (int i =0; i<arryData.count; i++) {
        GYAroundShopsCategoryModel * model = arryData[i];
        for (UIView *view in self.contentView.subviews)
        {
            if ([view isKindOfClass:[GYAroundShopsCategoryButton class]]) {
                GYAroundShopsCategoryButton * btn = (GYAroundShopsCategoryButton*)view;
                if (btn.index == i) {
                    [btn setTitle:model.categoryName forState:UIControlStateNormal];
                }
            }
        }
    }
}
@end
