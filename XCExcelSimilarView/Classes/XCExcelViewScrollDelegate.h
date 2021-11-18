//
//  XCExcelViewScrollDelegate.h
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XCCollectionType) {
    XCCollectionTypeRowTableCell,
    XCCollectionTypeRowHeaderView
};

@protocol XCExcelViewScrollDelegate <NSObject>

- (void)excelRowViewDidScroll:(UICollectionView *)scrollView collectionType:(XCCollectionType)type;

@end

NS_ASSUME_NONNULL_END
