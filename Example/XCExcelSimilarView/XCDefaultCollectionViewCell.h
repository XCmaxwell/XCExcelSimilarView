//
//  XCDefaultCollectionViewCell.h
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCDefaultCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@end


@interface XCDefaultReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *label;
@end


NS_ASSUME_NONNULL_END
