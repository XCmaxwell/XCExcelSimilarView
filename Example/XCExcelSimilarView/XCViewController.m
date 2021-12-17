//
//  XCViewController.m
//  XCExcelSimilarView
//
//  Created by xuecheng wang on 08/27/2021.
//  Copyright (c) 2021 xuecheng wang. All rights reserved.
//

#import "XCViewController.h"
#import "XCAlignedViewController.h"
#import "XCEXcelViewController.h"
#import "ConstHeader.h"

@interface XCViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray<NSArray *> *dataSource;
@end

@implementation XCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义CollectionViewLayout";
    [self.view addSubview:self.tableview];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDemolistTableViewCell forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XCAlignedViewController *vc = [XCAlignedViewController new];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                vc.title = @"左对齐";
                vc.layoutType = XCCollectionViewAlignedLayoutLeft;
            }
                break;
            case 1:{
                vc.title = @"居中";
                vc.layoutType = XCCollectionViewAlignedLayoutMiddle;
            }
                break;
            case 2:{
                vc.title = @"右对齐";
                vc.layoutType = XCCollectionViewAlignedLayoutRight;
            }
                break;
            default:
                break;
        }
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.navigationController pushViewController:[XCEXcelViewController new] animated:YES];
    }
}


- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:kDemolistTableViewCell];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @[@"左对齐",@"居中",@"右对齐"],
            @[@"左侧固定行数"]
        ];
    }
    return _dataSource;
}
@end
