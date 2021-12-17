//
//  XCFixedColumnLayout.m
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/12/17.
//

#import "XCFixedColumnLayout.h"

@interface XCFixedColumnLayout ()
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *array;
@end

@implementation XCFixedColumnLayout

- (instancetype)init {
    if (self = [super init]) {
        self.horSpace = 0.f;
        self.verSpace = 0.f;
        self.fixedColumn = 1;
        self.array = [NSMutableArray new];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    NSInteger section = [self.collectionView numberOfSections];
    if (self.array.count == section) {
        return;
    }
    
    CGFloat originY = 0.f;
    for (NSInteger i = 0; i < section; i++) {
        NSInteger row = [self.collectionView numberOfItemsInSection:i];
        CGFloat originX = 0.f;
        NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:row];
        UICollectionViewLayoutAttributes *attribute;
        for (NSInteger j = 0; j < row; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            attribute.frame = CGRectMake(originX, originY, attribute.size.width, attribute.size.height);
            originX = CGRectGetMaxX(attribute.frame) + self.horSpace;
            [rowArray addObject:attribute];
        }
        originY = CGRectGetMaxY(attribute.frame) + self.verSpace;
        [self.array addObject:rowArray];
    }
}

- (CGSize)collectionViewContentSize {
    if (self.array.count > 0) {
        UICollectionViewLayoutAttributes *attribute = (UICollectionViewLayoutAttributes *)self.array.lastObject.lastObject;
        return CGSizeMake(CGRectGetMaxX(attribute.frame), CGRectGetMaxY(attribute.frame));
    }
    return self.collectionView.frame.size;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<__kindof UICollectionViewLayoutAttributes *> *originArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray<__kindof UICollectionViewLayoutAttributes *> *updateArray = [NSMutableArray mutableCopy];
    for (int i = 0; i < originArray.count; i++) {
        UICollectionViewLayoutAttributes *orignAttr = originArray[i];
        UICollectionViewLayoutAttributes *updateAttr = [self layoutAttributesForItemAtIndexPath:orignAttr.indexPath];
        [updateArray addObject:updateAttr];
    }
    return updateArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section < self.array.count) && (indexPath.row < self.array[indexPath.section].count)) {
        return self.array[indexPath.section][indexPath.row];
    }
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = CGSizeMake(100, 25);
    return attribute;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end
