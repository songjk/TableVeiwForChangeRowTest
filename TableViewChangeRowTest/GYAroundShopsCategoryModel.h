//
//  GYAroundShopsCategoryModel.h
//  HSConsumer
//
//  Created by Apple03 on 15/11/20.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface GYAroundShopsCategoryModel : NSObject
@property (nonatomic,copy) NSString *  categoryId;
@property (nonatomic,copy) NSString *  categoryName;
@property (nonatomic,copy) NSString *  cid;
@property (nonatomic,strong) NSArray *  listMap;
@property (nonatomic,assign) BOOL isShowAll;
@end


@interface GYAroundShopsCategorySubModel : NSObject
@property (nonatomic,copy) NSString *  categoryId;
@property (nonatomic,copy) NSString *  categoryName;
@property (nonatomic,copy) NSString *  cid;
@end