//
//  XCExcelSimilarView.h
//  Pods-XCExcelSimilarView_Example
//
//  Created by MINI-02 on 2021/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XCExcelSimilarView;
@protocol  XCExcelSimilarViewDelegate <NSObject>

@optional

- (nonnull __kindof UICollectionViewCell *)excelRowView:(XCExcelSimilarView *)view customCellForCollectionView:(UICollectionView *)collectionView inColumn:(NSInteger)column;

/* tableview 代理 */
- (CGFloat)excelRowView:(XCExcelSimilarView *)view heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)excelRowView:(XCExcelSimilarView *)view heightForFooterInSection:(NSInteger)section;

- (CGFloat)excelRowView:(XCExcelSimilarView *)view heightForHeaderInSection:(NSInteger)section;

- (UIView *)excelRowView:(XCExcelSimilarView *)view viewForHeaderInSection:(NSInteger)section;

- (UIView *)excelRowView:(XCExcelSimilarView *)view viewForFooterInSection:(NSInteger)section;


@end

@interface XCExcelSimilarView : UIView

@property (nonatomic, weak) id<XCExcelSimilarViewDelegate> delegate;

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, strong, readwrite) NSArray<NSArray *> *dataArray;

+ (instancetype)excelViewWithFrame:(CGRect)frame delegate:(id<XCExcelSimilarViewDelegate>)delegate style:(UITableViewStyle)tableStyle;

- (void)registerCustomClass:(nonnull __kindof UICollectionViewCell *)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (void)registerCustomClass:(nonnull __kindof UICollectionViewCell *)cellClass forSupplementaryHeaderReuseIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
