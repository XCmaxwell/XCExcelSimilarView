//
//  XCCollectionAlignedFlowLayout.m
//  XCExcelSimilarView_Example
//
//  Created by MINI-01 on 2021/11/18.
//  Copyright © 2021 xuecheng wang. All rights reserved.
//

#import "XCCollectionAlignedFlowLayout.h"

#pragma mark - Custom Attributes
@interface UICollectionViewLayoutAttributes (XCCustom)

@end

@implementation UICollectionViewLayoutAttributes (XCCustom)

@end

#pragma mark - Custom AlignedFlowLayout
@interface XCCollectionAlignedFlowLayout()
@property (nonatomic, assign) XCCollectionViewAlignedLayout alignType;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *cacheFrameArray;
@end

@implementation XCCollectionAlignedFlowLayout

- (instancetype)initWithAlignType:(XCCollectionViewAlignedLayout)alignType {
    self = [super init];
    if (self) {
        _alignType = alignType;
        _cacheFrameArray = [NSMutableArray array];
    }
    return self;
}

/// 重写必调[super prepareLayout]、布局前调用、relaod后调用
- (void)prepareLayout {
    [super prepareLayout];
    [self.cacheFrameArray removeAllObjects];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        NSMutableArray *rowsArray = [NSMutableArray array];
        CGFloat originX = 0.f;
        CGFloat originY = 0.f;
        CGFloat contnetWidth = self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right;
        for (int j = 0; j < itemCount; j++) {
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            if (j == 0) {
                [rowsArray addObject:attribute];
                originX = attribute.frame.origin.x + attribute.frame.size.width + self.minimumLineSpacing;
                originY = attribute.frame.origin.y + attribute.frame.size.height + self.minimumInteritemSpacing;
            } else {
                CGRect frame = attribute.frame;
                CGFloat x = originX + attribute.frame.size.width  + self.minimumLineSpacing;
                //换行:  X置为初始值 Y重新赋值
                if (x > contnetWidth) {
                    frame.origin.x = self.sectionInset.left;
                    frame.origin.y = originY;
                //没换行: X继续累加  Y值不变
                } else {
                    frame.origin.x = originX;
                }
                attribute.frame = frame;
                [rowsArray addObject:attribute];
                originX = attribute.frame.origin.x + attribute.frame.size.width  + self.minimumLineSpacing;
                originY = attribute.frame.origin.y + attribute.frame.size.height + self.minimumInteritemSpacing;
            }
        }
        [self.cacheFrameArray addObject:rowsArray];
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *updatedAttributes = [NSMutableArray arrayWithArray:originalAttributes];
    for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
        if (!attributes.representedElementKind) {
            NSUInteger index = [updatedAttributes indexOfObject:attributes];
            updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }
    return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ((self.cacheFrameArray.count > indexPath.section) && (self.cacheFrameArray[indexPath.section].count > indexPath.row)) {
        return self.cacheFrameArray[indexPath.section][indexPath.row];
    }
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    return attributes;
}

- (UIEdgeInsets)evaluateInsetForSectionAtIndex:(NSInteger)index {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<XCCollectionViewDelegateAlignedLayout> delegate = (id<XCCollectionViewDelegateAlignedLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}




@end
