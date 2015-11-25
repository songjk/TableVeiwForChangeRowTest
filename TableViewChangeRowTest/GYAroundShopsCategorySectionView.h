//
//  GYAroundShopsCategorySectionView.h
//  HSConsumer
//
//  Created by Apple03 on 15/11/20.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYAroundShopsCategoryModel;

typedef  void (^chooseSectionBlock)(NSInteger index);
typedef  void (^showBlock)(NSInteger index);
@interface GYAroundShopsCategorySectionView : UIView
-(void)setViewWithData:(GYAroundShopsCategoryModel *)model;
@property (nonatomic,strong) chooseSectionBlock chooseBlock;
@property (nonatomic,strong) showBlock ShowBlock;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) GYAroundShopsCategoryModel *categoryModel;
@end
