//
//  GYAroundShopsCategoryCell.h
//  HSConsumer
//
//  Created by Apple03 on 15/11/20.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYAroundShopsCategoryCell;
@protocol GYAroundShopsCategoryCellDelegate <NSObject>
@optional
-(void)AroundShopsCategoryCellDidChooseItemWith:(NSIndexPath *)indexP index:(NSInteger)index;

@end
#define KAroundShopsCategoryCell @"AroundShopsCategoryCell"
@interface GYAroundShopsCategoryCell : UITableViewCell
+(instancetype)cellWithTableVeiw:(UITableView *)tableView;
-(void)setCellDetailWithArray:(NSArray *)arryData;

@property(nonatomic,strong) NSIndexPath * indexP;
@property (nonatomic,weak) id<GYAroundShopsCategoryCellDelegate>delegate;
@end
