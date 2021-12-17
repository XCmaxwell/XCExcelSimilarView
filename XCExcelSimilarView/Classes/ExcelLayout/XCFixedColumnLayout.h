//
//  XCFixedColumnLayout.h
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XCFixedColumnLayout;
@protocol XCCollectionViewDelegateFixedColumnLayout <UICollectionViewDelegate>

@required

/// excel表格, 不同列宽度不同，同列宽度相同
/// @param fixedColumnLayout 布局layout
/// @param index 表格所在列
- (CGFloat)layout:(XCFixedColumnLayout*)fixedColumnLayout  widthForItemAtIndex:(NSInteger)index;

/// excel表格, 不同行高度不同，同行高度相同
/// @param fixedColumnLayout 布局layout
/// @param section 列表Item 所在行
- (CGFloat)layout:(XCFixedColumnLayout*)fixedColumnLayout  widthForItemAtSection:(NSInteger)section;

@end


@interface XCFixedColumnLayout : UICollectionViewLayout

/// excel 横向单元格间隙 默认为0.f
@property (nonatomic, assign) CGFloat horSpace;
/// excel 纵向单元格间隙 默认为0.f
@property (nonatomic, assign) CGFloat verSpace;
/// 纵向 左侧固定悬浮列数，默认为1
@property (nonatomic, assign) NSInteger fixedColumn;
/// 整个CollectionView的sectionInset， 不同section都是一个sectionInset， 默认为UIEdgeInsetZero
@property (nonatomic) UIEdgeInsets sectionInset;

@end

NS_ASSUME_NONNULL_END
