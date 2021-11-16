//
//  XCViewController.m
//  XCExcelSimilarView
//
//  Created by xuecheng wang on 08/27/2021.
//  Copyright (c) 2021 xuecheng wang. All rights reserved.
//

#import "XCViewController.h"
#import <XCExcelSimilarView.h>

@interface XCViewController ()<XCExcelSimilarViewDelegate>

@property (nonatomic, strong) XCExcelSimilarView *excelView;

@end

@implementation XCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.excelView = [XCExcelSimilarView excelViewWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height-88) delegate:self style:UITableViewStyleGrouped];
    [self.view addSubview:self.excelView];
    self.excelView.dataArray = @[@[@"01",@"02",@"03",@"04"],@[@"11",@"12",@"13",@"14"],@[@"21",@"22",@"23",@"24"]];
}

#pragma mark - XCExcelSimilarViewDelegate
- (CGFloat)excelRowView:(XCExcelSimilarView *)view heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

@end
