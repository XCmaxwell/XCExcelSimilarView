//
//  XCCollectionAlignedFlowLayout.h
//  XCExcelSimilarView_Example
//
//  Created by MINI-01 on 2021/11/18.
//  Copyright © 2021 xuecheng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XCCollectionViewAlignedLayout) {
    XCCollectionViewAlignedLayoutLeft,
    XCCollectionViewAlignedLayoutMiddle,
    XCCollectionViewAlignedLayoutRight
};

NS_ASSUME_NONNULL_BEGIN

@class XCCollectionAlignedFlowLayout;

@protocol XCCollectionViewDelegateAlignedLayout <UICollectionViewDelegateFlowLayout>

//- (UICollectionViewLayoutAttributes *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout forAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XCCollectionAlignedFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) XCCollectionViewAlignedLayout alignedType;

- (instancetype)initWithAlignType:(XCCollectionViewAlignedLayout)alignType;

@end

NS_ASSUME_NONNULL_END
