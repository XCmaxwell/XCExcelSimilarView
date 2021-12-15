//
//  XCCollectionAlignedFlowLayout.m
//  XCExcelSimilarView_Example
//
//  Created by MINI-01 on 2021/11/18.
//  Copyright © 2021 xuecheng wang. All rights reserved.
//

#import "XCCollectionAlignedFlowLayout.h"

#pragma mark - Custom AlignedFlowLayout
@interface XCCollectionAlignedFlowLayout()
@property (nonatomic, assign, readwrite) XCCollectionViewAlignedLayout alignedType;
@property (nonatomic, strong, readwrite) NSMutableDictionary *cacheDictionary;
@end

@implementation XCCollectionAlignedFlowLayout

- (instancetype)initWithAlignType:(XCCollectionViewAlignedLayout)alignType {
    self = [super init];
    if (self) {
        _alignedType = alignType;
        _cacheDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

/// 重写必调[super prepareLayout]、布局前调用、relaod后调用
- (void)prepareLayout {
    [super prepareLayout];
    [self.cacheDictionary removeAllObjects];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    if (originalAttributes.count <= 0) {
        return originalAttributes;
    }
    
    NSMutableArray *updatedAttributes = [[NSMutableArray alloc] initWithArray:originalAttributes copyItems:YES];
    NSInteger startIndex = -1, endIndex = -1, section = -1;
    CGFloat lastX = self.collectionView.frame.size.width, minSpace = 0.f;
    for (int i = 0; i < originalAttributes.count; i++) {
        UICollectionViewLayoutAttributes *attribute = updatedAttributes[i];
        if (attribute.representedElementKind) {//非cell类型
            id<XCCollectionViewDelegateAlignedLayout> delegate = (id)self.collectionView.delegate;
            if (attribute.representedElementCategory == UICollectionElementCategoryDecorationView) {
                if ([delegate respondsToSelector:@selector(layout:customAttributes:forDecorationViewAtIndexPath:)]) {
                    [delegate layout:self customAttributes:attribute forDecorationViewAtIndexPath:attribute.indexPath];
                }
            } else {
                if ([delegate respondsToSelector:@selector(layout:customAttributes:forSupplementaryViewAtIndexPath:)]) {
                    [delegate layout:self customAttributes:attribute forSupplementaryViewAtIndexPath:attribute.indexPath];
                }
            }
            
        } else {//cell类型
            //换行或初识行
            if (attribute.frame.origin.x < lastX) {
                if (startIndex != -1) {
                    //重排上一行frame
                    CGFloat originX = [self calculateOrignLastX:lastX forSection:section];
                    [self updatedAttributesArray:updatedAttributes
                                           start:startIndex
                                             end:endIndex
                                         originX:originX
                                        minSpace:minSpace];
                }
                if (section != attribute.indexPath.section) {
                    section = attribute.indexPath.section;
                    minSpace = [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
                }
                lastX = [self evaluateInsetForSectionAtIndex:section].left + attribute.frame.size.width;
                startIndex = i;
            } else {
                lastX = lastX + minSpace + attribute.frame.size.width;
            }
            endIndex = i;
        }
    }
    if (startIndex != -1) {
        CGFloat originX = [self calculateOrignLastX:lastX forSection:section];
        [self updatedAttributesArray:updatedAttributes
                               start:startIndex
                                 end:endIndex
                             originX:originX
                            minSpace:minSpace
        ];
    }
    return updatedAttributes;
}

#pragma mark - Private
- (CGFloat)calculateOrignLastX:(CGFloat)lastX forSection:(NSInteger)section  {
    UIEdgeInsets inset = [self evaluateInsetForSectionAtIndex:section];
    CGFloat originX;
    switch (self.alignedType) {
        case XCCollectionViewAlignedLayoutLeft:
            originX = inset.left;
            break;
        case XCCollectionViewAlignedLayoutMiddle:
            originX = inset.left + (self.collectionView.frame.size.width - lastX - inset.right)/2;
            break;
        case XCCollectionViewAlignedLayoutRight:
            originX = inset.left + (self.collectionView.frame.size.width - lastX - inset.right);
            break;
        default:
            break;
    }
    return originX;
}

- (void)updatedAttributesArray:(nullable NSMutableArray<__kindof UICollectionViewLayoutAttributes *> *)attrArray start:(NSInteger)startIndex end:(NSInteger)endIndex originX:(CGFloat)originX minSpace:(CGFloat)minInterSpace {
    CGFloat x = originX;
    for (NSInteger j = startIndex; j <= endIndex; j++) {
        UICollectionViewLayoutAttributes * attributes = attrArray[j];
        CGRect frame = attributes.frame;
        frame.origin.x = x;
        attributes.frame = frame;
        x += frame.size.width + minInterSpace;
        [attrArray setObject:attributes atIndexedSubscript:j];
    }
}

#pragma mark - 获取collectionView代理设置 sectionInset minimumInteritemSpacing
- (UIEdgeInsets)evaluateInsetForSectionAtIndex:(NSInteger)index {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [(id<XCCollectionViewDelegateAlignedLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}

- (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [(id)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
    } else {
        return self.minimumInteritemSpacing;
    }
}

@end
