//
//  GYAroundShopsCategoryController.m
//  HSConsumer
//
//  Created by Apple03 on 15/11/20.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import "GYAroundShopsCategoryController.h"
#import "GYAroundShopsCategoryModel.h"
#import "GYAroundShopsCategorySectionView.h"
#import "GYAroundShopsCategoryCell.h"
//  收起来显示行数
#define KfirstShowRowCont 1

@interface GYAroundShopsCategoryController ()<UITableViewDataSource,UITableViewDelegate,GYAroundShopsCategoryCellDelegate>
@property (nonatomic,strong) NSMutableArray *marrData;

@property (nonatomic,strong) NSMutableArray *marrSection;
@property (nonatomic,strong) NSMutableArray *marrShowAll;
@property (nonatomic,strong) NSMutableArray *marrRows;
@property (nonatomic,weak) UITableView * tableView;
@end

@implementation GYAroundShopsCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(NSMutableArray *)marrData
{
    if (!_marrData) {
        _marrData = [NSMutableArray array];
    }
    return _marrData;
}
-(NSMutableArray *)marrShowAll
{
    if (!_marrShowAll) {
        _marrShowAll = [NSMutableArray array];
    }
    return _marrShowAll;
}
-(NSMutableArray *)marrSection
{
    if (!_marrSection) {
        _marrSection = [NSMutableArray array];
    }
    return _marrSection;
}
-(NSMutableArray *)marrRows
{
    if (!_marrRows) {
        _marrRows = [NSMutableArray array];
    }
    return _marrRows;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor grayColor];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
-(void)setup
{
    self.title = @"收放视图";
    [self.tableView registerClass:[GYAroundShopsCategoryCell class] forCellReuseIdentifier:KAroundShopsCategoryCell];
    [self getData];
}
// 重新组织数据为弯曲数据
-(void)reMakeData
{
    int count = 3;
    for (int i =0; i<self.marrData.count; i++)
    {
        GYAroundShopsCategoryModel *categoryModel = self.marrData[i];
        GYAroundShopsCategoryModel *reCategoryModel = [[GYAroundShopsCategoryModel alloc] init];
        reCategoryModel.categoryId = categoryModel.categoryId;
        reCategoryModel.categoryName = categoryModel.categoryName;
        reCategoryModel.cid = categoryModel.cid;
        [self.marrSection addObject:reCategoryModel];
        [self.marrShowAll addObject:@"0"];
        NSMutableArray * marrRowInSection = [NSMutableArray array];
        NSMutableArray * marrRow = [NSMutableArray array];
        for (int j =0; j<categoryModel.listMap.count; j++)
        {
            GYAroundShopsCategorySubModel * subModel = categoryModel.listMap[j];
            [marrRow addObject:subModel];
            if ((j+1)%count == 0)
            {
                [marrRowInSection addObject:marrRow];
                marrRow = [NSMutableArray array];
            }
            else
            {
                if(categoryModel.listMap.count == j+1)
                {
                    [marrRowInSection addObject:marrRow];
                }
            }
        }
        [self.marrRows addObject:marrRowInSection];
    }
}
// 垂直数据(一般网络请求未这种数据)
-(void)getData
{
    for (int i = 0; i<8; i++)
    {
        GYAroundShopsCategoryModel *categoryModel = [[GYAroundShopsCategoryModel alloc] init];
        categoryModel.categoryId = [NSString stringWithFormat:@"categoryId%d",i];
        categoryModel.categoryName = [NSString stringWithFormat:@"categoryName%d",i];
        categoryModel.cid = [NSString stringWithFormat:@"cid%d",i];
        
        NSMutableArray * marrData = [NSMutableArray array];
        for (int j = 0; j<10; j++)
        {
            GYAroundShopsCategorySubModel * subModel = [[GYAroundShopsCategorySubModel alloc] init];
            subModel.categoryId = [NSString stringWithFormat:@"SubId%d",i];
            subModel.categoryName = [NSString stringWithFormat:@"SubName%d",i];
            subModel.cid = [NSString stringWithFormat:@"Subcid%d",i];
            [marrData addObject:subModel];
        }
        categoryModel.listMap = [NSArray arrayWithArray:marrData];
        [self.marrData addObject:categoryModel];
    }
    [self reMakeData];
    [self.tableView reloadData];
}
#pragma mark uitableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.marrSection.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.marrRows.count>0)
    {
        NSMutableArray * arry = self.marrRows[section];
        NSString * strSHow = self.marrShowAll[section];
        if ([strSHow isEqualToString:@"0"] && arry.count>KfirstShowRowCont) {
            return KfirstShowRowCont;
        }
        return arry.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.marrSection.count>section)
    {
        GYAroundShopsCategorySectionView * view = [[GYAroundShopsCategorySectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        __block GYAroundShopsCategoryModel * model = self.marrSection[section];
        __weak GYAroundShopsCategoryController * vcSelf = self;
        view.chooseBlock = ^(NSInteger secton)
        {
            [vcSelf toSearchGoodsWithIndex:section cellIndexPath:nil type:0];
        };
        view.ShowBlock = ^(NSInteger section)
        {
            model.isShowAll = !model.isShowAll;
            [vcSelf.marrShowAll removeObjectAtIndex:section];
            if (model.isShowAll)
            {
                [vcSelf.marrShowAll insertObject:@"1" atIndex:section];
            }
            else
            {
                [vcSelf.marrShowAll insertObject:@"0" atIndex:section];
            }
            [vcSelf.tableView reloadData];
        };
        view.index = section;
        [view setViewWithData:model];
        return view;
    }
    else
    {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYAroundShopsCategoryCell * cell = [GYAroundShopsCategoryCell cellWithTableVeiw:tableView];
    cell.indexP = indexPath;
    cell.delegate =self;
    NSMutableArray * arry = self.marrRows[indexPath.section];
    NSMutableArray * arrCell = arry[indexPath.row];
    [cell setCellDetailWithArray:arrCell];
    return cell;
}
#pragma mark GYAroundShopsCategoryCellDelegate
-(void)AroundShopsCategoryCellDidChooseItemWith:(NSIndexPath *)indexP index:(NSInteger)index
{
    [self toSearchGoodsWithIndex:index cellIndexPath:indexP type:1];
}
-(void)toSearchGoodsWithIndex:(NSInteger)index cellIndexPath:(NSIndexPath *)indexPath type:(NSInteger)type
{
    GYAroundShopsCategoryModel * model = nil;
    if (type ==1) {
        
        NSMutableArray * arry = self.marrRows[indexPath.section];
        NSMutableArray * arrCell = arry[indexPath.row];
        model = arrCell[index];
    }
    else
    {
        model = self.marrSection[index];
    }
    NSString * strcategoryName = model.categoryName;
    strcategoryName = [strcategoryName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    UIViewController * vc = [[UIViewController alloc] init];
    vc.title = strcategoryName;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
