//
//  XCNormalRowCell.m
//  Pods
//
//  Created by MINI-01 on 2021/11/3.
//

#import "XCNormalRowCell.h"
#import "XCCollectionViewFlowLayout.h"
#import "XCDefaultCollectionViewCell.h"

@interface XCNormalRowCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) BOOL bRegisterCell;

@end

@implementation XCNormalRowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)registerCollectionViewCell:(NSArray<__kindof UICollectionViewCell *> *)cellArray reusableView:(NSArray<__kindof UICollectionReusableView *> *)reusViewArray {
    if (cellArray.count > 0) {
        for (Class class in cellArray) {
            [self.collectionView registerClass:class forCellWithReuseIdentifier:NSStringFromClass(class)];
        }
    }
    if (reusViewArray.count > 0) {
        for (Class class in reusViewArray) {
            [self.collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(class)];
        }
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     XCDefaultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCDefaultCollectionViewCell" forIndexPath:indexPath];
     cell.backgroundColor = [UIColor redColor];
     return cell;
 }

 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
     if (kind == UICollectionElementKindSectionHeader) {
         XCDefaultReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XCDefaultReusableView" forIndexPath:indexPath];
         view.backgroundColor = [UIColor yellowColor];
         return view;
     }
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
        XCCollectionViewFlowLayout *dcLayout = [XCCollectionViewFlowLayout new];
        dcLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        dcLayout.sectionHeadersPinToVisibleBounds = true;
        dcLayout.minimumLineSpacing = CGFLOAT_MIN;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcLayout];
        _collectionView.showsHorizontalScrollIndicator= false;
        _collectionView.bounces = false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
