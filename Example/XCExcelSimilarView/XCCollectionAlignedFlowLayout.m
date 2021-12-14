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
    NSMutableArray *updatedAttributes = [[NSMutableArray alloc] initWithArray:originalAttributes copyItems:YES];
    NSIndexPath *indexPath;
    CGFloat lastX = 0.f, contentWidth = 0.f;
    NSInteger startIndex = 0, endIndex = 0;
    
    for (int i = 0; i < originalAttributes.count; i++) {
        UICollectionViewLayoutAttributes * attributes = originalAttributes[i];
        if (attributes.indexPath.section == 1) {
            NSLog(@"%@", attributes.indexPath);
            startIndex = 0;
            endIndex = 0;
            lastX = 0.f,
            contentWidth = 0.f;
        }
        indexPath = attributes.indexPath;
        // cell类型
        if (!attributes.representedElementKind) {
            
            CGFloat minSpace = [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section];
            // 换行或者第一行初识位置
            if (attributes.frame.origin.x < lastX || (startIndex == 0)) {
                if (startIndex != 0) {
                    [self updatedAttributesArray:updatedAttributes
                                           start:startIndex
                                             end:endIndex
                                         originX:[self calculateOrignXContentWidth:contentWidth forSection:indexPath.section]
                                        minSpace:minSpace];
                }
                startIndex = indexPath.row;
                contentWidth = attributes.frame.size.width;
            } else {
                contentWidth += attributes.frame.size.width + minSpace;
            }
            endIndex = indexPath.row;
            lastX = attributes.frame.origin.x + attributes.frame.size.width + minSpace;
        }
    }
    return updatedAttributes;
}

- (CGFloat)calculateOrignXContentWidth:(CGFloat)width forSection:(NSInteger)section  {
    UIEdgeInsets inset = [self evaluateInsetForSectionAtIndex:section];
    CGFloat originX = inset.left;
//    switch (self.alignedType) {
//        case XCCollectionViewAlignedLayoutLeft:
//            break;
//        case XCCollectionViewAlignedLayoutMiddle:
//            originX += (self.collectionView.frame.size.width - inset.left - inset.right - width)/2;
//            break;
//        case XCCollectionViewAlignedLayoutRight:
//            originX += (self.collectionView.frame.size.width - inset.left - inset.right - width);
//            break;
//        default:
//            break;
//    }
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

- (void)customLayoutAttributesArray:(NSMutableArray *)rowArray start:(int)startIndex end:(int)endIndex  sectionds:(UIEdgeInsets)inset minSpace:(CGFloat)minInterSpace {
    NSArray *array = [rowArray copy];
    switch (self.alignedType) {
        case XCCollectionViewAlignedLayoutLeft:
        {
            CGFloat orignX = inset.left;
            for (int k = startIndex; k <= endIndex; k++) {
                UICollectionViewLayoutAttributes *attribute = array[k];
                CGRect frame = attribute.frame;
                frame.origin.x = orignX;
                attribute.frame = frame;
                [rowArray setObject:attribute atIndexedSubscript:k];
                orignX = orignX + frame.size.width + minInterSpace;
            }
        }
            break;
        case XCCollectionViewAlignedLayoutRight:
        {
            CGFloat orignX = self.collectionView.frame.size.width - inset.right;
            for (int k = endIndex; k >= startIndex; k--) {
                UICollectionViewLayoutAttributes *attribute = array[k];
                CGRect frame = attribute.frame;
                frame.origin.x = orignX - frame.size.width;
                attribute.frame = frame;
                [rowArray setObject:attribute atIndexedSubscript:k];
                orignX = frame.origin.x - minInterSpace;
            }
        }
            break;
        default:
            break;
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


//for (int i = 0; i < sectionCount; i++) {
//    NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
//    NSMutableArray *rowsArray = [[NSMutableArray alloc] initWithCapacity:itemCount];
//    UIEdgeInsets inset = [self evaluateInsetForSectionAtIndex:i];
//    CGFloat minInterSpace =  [self evaluatedMinimumInteritemSpacingForSectionAtIndex:i];
//    CGFloat originX = 0;
//    //同一行Index 区间
//    int startIndex = 0; int endIndex = 0;
//    for (int j = 0; j < itemCount; j++) {
//        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
//        CGRect frame = attribute.frame;
//        //表示换行判断、排除第0个不算换行
//        if ((frame.origin.x < originX) && j != 0) {
//            [self customLayoutAttributesArray:rowsArray start:startIndex end:endIndex sectionds:inset minSpace:minInterSpace];
//            startIndex = j;
//        }
//        originX = attribute.frame.origin.x + attribute.frame.size.width + minInterSpace;
//        endIndex = j;
//        [rowsArray addObject:attribute];
//        if (j == itemCount - 1) {
//            [self customLayoutAttributesArray:rowsArray start:startIndex end:endIndex sectionds:inset minSpace:minInterSpace];
//        }
//    }
//    [self.cacheFrameArray addObject:rowsArray];
//}

@end
