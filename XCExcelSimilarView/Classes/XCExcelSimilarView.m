//
//  XCExcelSimilarView.m
//  Pods-XCExcelSimilarView_Example
//
//  Created by MINI-02 on 2021/8/27.
//

#import "XCExcelSimilarView.h"
#import "XCNormalRowCell.h"
#import "XCDefaultCollectionViewCell.h"

@interface XCExcelSimilarView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XCExcelSimilarView

+ (instancetype)excelViewWithFrame:(CGRect)frame delegate:(id<XCExcelSimilarViewDelegate>)delegate style:(UITableViewStyle)tableStyle {
    XCExcelSimilarView *excelView = [[XCExcelSimilarView alloc] initWithFrame:frame];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:tableStyle];
    tableView.delegate = excelView;
    tableView.dataSource = excelView;
    [tableView registerClass:[XCNormalRowCell class] forCellReuseIdentifier:XCNormalRowCellID];
    [excelView addSubview:tableView];
    excelView.tableView = tableView;
    
    excelView.delegate = delegate;
    return excelView;
}

- (void)setDataArray:(NSArray<NSArray *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCNormalRowCell *cell = [tableView dequeueReusableCellWithIdentifier:XCNormalRowCellID];
    NSArray *cellArray;
    NSArray *reusViewArray;
    if ([self.delegate respondsToSelector:@selector(excelRowView:registerCustomCellForCollectionView:)]) {
        cellArray = [self.delegate excelRowView:self registerCustomCellForCollectionView:cell.collectionView];
    } else {
        cellArray = @[[XCDefaultCollectionViewCell class]];
    }
    if ([self.delegate respondsToSelector:@selector(excelRowView:registerCustomReusableViewForCollectionView:)] ) {
        reusViewArray = [self.delegate excelRowView:self registerCustomReusableViewForCollectionView:cell.collectionView];
    } else {
        reusViewArray = @[[XCDefaultReusableView class]];
    }
    [cell registerCollectionViewCell:cellArray reusableView:reusViewArray];
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
