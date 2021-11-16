//
//  XCNormalRowCell.h
//  Pods
//
//  Created by MINI-01 on 2021/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define XCNormalRowCellID @"XCNormalRowCell"

@interface XCNormalRowCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)registerCollectionViewCell:(NSArray<__kindof UICollectionViewCell *> *)cellArray reusableView:(NSArray<__kindof UICollectionReusableView *> *)reusViewArray;

@end

NS_ASSUME_NONNULL_END
