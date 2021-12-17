//
//  XCEXcelViewController.m
//  XCExcelSimilarView_Example
//
//  Created by MINI-01 on 2021/12/17.
//  Copyright © 2021 xuecheng wang. All rights reserved.
//

#import "XCEXcelViewController.h"
#import "XCDefaultCollectionViewCell.h"
#import "XCFixedColumnLayout.h"
#import "ConstHeader.h"

@interface XCEXcelViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation XCEXcelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 40;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 20);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XCDefaultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAlinedCollectionCell forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    return cell;
}





- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XCFixedColumnLayout *layout = [XCFixedColumnLayout new];
//        layout.sectionHeadersPinToVisibleBounds = true;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[XCDefaultCollectionViewCell class] forCellWithReuseIdentifier:kAlinedCollectionCell];
        _collectionView.showsHorizontalScrollIndicator= false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


@end
