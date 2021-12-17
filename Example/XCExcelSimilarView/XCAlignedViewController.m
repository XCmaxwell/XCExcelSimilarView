//
//  XCAlignedViewController.m
//  XCExcelSimilarView_Example
//
//  Created by MINI-01 on 2021/12/15.
//  Copyright © 2021 xuecheng wang. All rights reserved.
//

#import "XCAlignedViewController.h"
#import "XCDefaultCollectionViewCell.h"
#import "XCDefaultCollectionViewCell.h"
#import "ConstHeader.h"

@interface XCAlignedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSArray *> *dataArray;

@end

@implementation XCAlignedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [NSString stringWithFormat:@"%ld-%ld%@",(long)indexPath.section, (long)indexPath.row, self.dataArray[indexPath.section][indexPath.row]];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:22]};
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attrs context:nil];
    return CGSizeMake(20+rect.size.width, 10+rect.size.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(80, 60);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     XCDefaultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAlinedCollectionCell forIndexPath:indexPath];
     cell.label.text = [NSString stringWithFormat:@"%ld-%ld%@",(long)indexPath.section, (long)indexPath.row, self.dataArray[indexPath.section][indexPath.row]];
     //frame布局cell复用时，label的frame也会有缓存，所以重设frame很重要
     cell.label.frame = cell.bounds;
     return cell;
 }

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        XCDefaultReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kAlinedCollectionHeader forIndexPath:indexPath];
        return headerView;
    } else {
        return nil;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

- (void)layout:(UICollectionViewLayout*)collectionViewLayout customAttributes:(UICollectionViewLayoutAttributes *)attributes forDecorationViewAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)layout:(UICollectionViewLayout*)collectionViewLayout customAttributes:(UICollectionViewLayoutAttributes *)attributes forSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath {
    attributes.alpha = indexPath.section%2 ==0?0.5:1;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XCCollectionAlignedFlowLayout *layout = [[XCCollectionAlignedFlowLayout alloc] initWithAlignType:self.layoutType];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XCDefaultCollectionViewCell class] forCellWithReuseIdentifier:kAlinedCollectionCell];
        [_collectionView registerClass:[XCDefaultReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kAlinedCollectionHeader];
    }
    return _collectionView;
}

- (NSArray<NSArray *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            @[@"汉字",@"厚",@"汉族",@"度啊",@"哈哈哈",@"音乐",@"音乐",@"开发者巴基斯坦",@"印度",
              @"哈哈哈",@"丑过",@"漂亮国",@"开发者巴基斯坦",@"印度阿三"],
            @[@"汉字",@"厚",@"汉族",@"三啊倒霉国",@"哈哈哈",@"音乐",@"音乐",@"开发者巴基斯坦",@"印度",
              @"大不列颠及北爱尔兰",@"度啊",@"哈哈哈",@"音乐",@"哈",@"澳大利亚",@"偶"],
            @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度",
              @"大不及北爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚"],
            @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度大及北",
              @"爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚",@"辅导老师"]
        ];
    }
    return _dataArray;
}

@end
