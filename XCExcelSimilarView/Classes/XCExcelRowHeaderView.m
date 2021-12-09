//
//  XCExcelRowHeaderView.m
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/11/17.
//

#import "XCExcelRowHeaderView.h"
#import "XCCollectionViewFlowLayout.h"
//#import "XCDefaultCollectionViewCell.h"

@interface XCExcelRowHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation XCExcelRowHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
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
//     cell.label.text = [NSString stringWithFormat:@"头%zd", indexPath.row];
     cell.backgroundColor = [UIColor orangeColor];
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
    return CGSizeMake(80,60);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(80, 60);
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XCCollectionViewFlowLayout *dcLayout = [XCCollectionViewFlowLayout new];
        dcLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        dcLayout.sectionHeadersPinToVisibleBounds = true;
        dcLayout.minimumLineSpacing = CGFLOAT_MIN;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:dcLayout];
        _collectionView.showsHorizontalScrollIndicator= false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        [_collectionView registerClass:[XCDefaultReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XCDefaultReusableView"];
//        [_collectionView registerClass:[XCDefaultCollectionViewCell class] forCellWithReuseIdentifier:@"XCDefaultCollectionViewCell"];
    }
    return _collectionView;
}

@end
