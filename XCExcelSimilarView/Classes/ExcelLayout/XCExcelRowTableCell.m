//
//  XCExcelRowTableCell.m
//  Pods
//
//  Created by MINI-01 on 2021/11/3.
//

#import "XCExcelRowTableCell.h"


@interface XCExcelRowTableCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation XCExcelRowTableCell

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)registerCollectionViewCell:(NSArray<__kindof UICollectionViewCell *> *)cellArray reusableView:(NSArray<__kindof UICollectionReusableView *> *)reusViewArray {
    if (_collectionView) {
        return;
    }
//    [self addSubview:self.collectionView];
//    if (cellArray.count > 0) {
//        for (NSDictionary *dic in cellArray) {
//            [self.collectionView registerClass:class forCellWithReuseIdentifier:dic.k];
//        }
//    }
//    if (reusViewArray.count > 0) {
//        for (Class class in reusViewArray) {
//            [self.collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(class)];
//        }
//    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        if ([self.delegate respondsToSelector:@selector(excelRowViewDidScroll:collectionType:)]) {
            [self.delegate excelRowViewDidScroll:self.collectionView collectionType:XCCollectionTypeRowTableCell];
        }
    }
}

#pragma mark - UICollectionViewDelegate & DataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCDefaultCollectionViewCell" forIndexPath:indexPath];
//     cell.label.text = [NSString stringWithFormat:@"行列%zd", indexPath.row];
     return cell;
 }

 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//     if (kind == UICollectionElementKindSectionHeader) {
//         XCDefaultReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XCDefaultReusableView" forIndexPath:indexPath];
//         view.backgroundColor = [UIColor yellowColor];
//         return view;
//     }
     return nil;
 }

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(80, 80);
}

#pragma mark -
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcLayout = [UICollectionViewFlowLayout new];
        dcLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        dcLayout.sectionHeadersPinToVisibleBounds = true;
        dcLayout.minimumLineSpacing = CGFLOAT_MIN;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcLayout];
        _collectionView.showsHorizontalScrollIndicator= false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
