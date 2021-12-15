//
//  XCExcelRowHeaderView.h
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/11/17.
//

#import <UIKit/UIKit.h>
#import "XCExcelViewScrollDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface XCExcelRowHeaderView : UIView

@property (nonatomic, weak) id<XCExcelViewScrollDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
