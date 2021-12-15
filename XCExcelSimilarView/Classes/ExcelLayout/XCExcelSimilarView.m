//
//  XCExcelSimilarView.m
//  Pods-XCExcelSimilarView_Example
//
//  Created by MINI-02 on 2021/8/27.
//

#import "XCExcelSimilarView.h"
#import "XCExcelRowTableCell.h"
#import "XCExcelRowHeaderView.h"
//#import "XCDefaultCollectionViewCell.h"


@interface XCExcelSimilarView ()<UITableViewDelegate, UITableViewDataSource,XCExcelViewScrollDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XCExcelRowHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray<__kindof UICollectionViewCell *> *cellArray;
@property (nonatomic, strong) NSMutableArray<__kindof UICollectionReusableView *> *headerArray;
@property (nonatomic, assign) CGFloat cacheOffsetX;

@end

@implementation XCExcelSimilarView

+ (instancetype)excelViewWithFrame:(CGRect)frame delegate:(id<XCExcelSimilarViewDelegate>)delegate style:(UITableViewStyle)tableStyle {
    XCExcelSimilarView *excelView = [[XCExcelSimilarView alloc] initWithFrame:frame];
    XCExcelRowHeaderView *headerView = [[XCExcelRowHeaderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 60)];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, frame.size.width, frame.size.height - 60) style:tableStyle];
    tableView.delegate = excelView;
    tableView.dataSource = excelView;
    [tableView registerClass:[XCExcelRowTableCell class] forCellReuseIdentifier:XCNormalRowCellID];
    [excelView addSubview:tableView];
    excelView.tableView = tableView;
    excelView.delegate = delegate;
    
    headerView.delegate = excelView;
    excelView.headerView = headerView;
    [excelView addSubview:headerView];
    return excelView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDataArray:(NSArray<NSArray *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)excelRowViewDidScroll:(UICollectionView *)scrollView collectionType:(XCCollectionType)type {
    self.cacheOffsetX = scrollView.contentOffset.x;
    for (XCExcelRowTableCell *cell in self.tableView.visibleCells) {
        if (scrollView != cell.collectionView) {
            cell.collectionView.contentOffset = CGPointMake(self.cacheOffsetX, 0);
        }
    }
    if (type == XCCollectionTypeRowTableCell) {
        self.headerView.collectionView.contentOffset = CGPointMake(self.cacheOffsetX, 0);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        for (XCExcelRowTableCell *cell in self.tableView.visibleCells) {
            cell.collectionView.contentOffset = CGPointMake(self.cacheOffsetX, 0);
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCExcelRowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:XCNormalRowCellID];
    cell.delegate = self;
//    [cell registerCollectionViewCell:self.cellArray reusableView:self.headerArray];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(excelRowView:heightForRowAtIndexPath:)]) {
        return [self.delegate excelRowView:self heightForRowAtIndexPath:indexPath];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(excelRowView:heightForHeaderInSection:)]) {
        return [self.delegate excelRowView:self heightForHeaderInSection:section];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(excelRowView:heightForFooterInSection:)]) {
        return [self.delegate excelRowView:self heightForFooterInSection:section];
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(excelRowView:viewForHeaderInSection:)]) {
        return [self.delegate excelRowView:self viewForHeaderInSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(excelRowView:viewForFooterInSection:)]) {
        return [self.delegate excelRowView:self viewForFooterInSection:section];
    }
    return nil;
}

@end
