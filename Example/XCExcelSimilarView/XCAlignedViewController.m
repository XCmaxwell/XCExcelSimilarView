//
//  XCAlignedViewController.m
//  XCExcelSimilarView_Example
//
//  Created by MINI-01 on 2021/12/15.
//  Copyright © 2021 xuecheng wang. All rights reserved.
//

#import "XCAlignedViewController.h"
#import "XCDefaultCollectionViewCell.h"


@interface XCAlignedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSArray *> *dataArray;

@end

@implementation XCAlignedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.dataArray =@[
    @[@"汉字",@"厚",@"汉族",@"度啊",@"哈哈哈",@"音乐",@"音乐",@"开发者巴基斯坦",@"印度"],
    @[@"汉字",@"厚",@"汉族",@"度啊",@"哈哈哈",@"音乐",@"音乐",@"开发者巴基斯坦",@"印度",@"大不列颠及北爱尔兰",@"度啊",@"哈哈哈",@"音乐",@"哈",@"澳大利亚",@"偶"],
    @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度",@"大不及北爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚"],
    @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度",@"大不及北爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚",@"ali辅导老师"]
    ];
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
     XCDefaultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCDefaultCollectionViewCell" forIndexPath:indexPath];
     cell.label.text = [NSString stringWithFormat:@"%ld-%ld%@",(long)indexPath.section, (long)indexPath.row, self.dataArray[indexPath.section][indexPath.row]];;
     cell.label.frame = cell.bounds;
     return cell;
 }

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        XCDefaultReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XCDefaultReusableView" forIndexPath:indexPath];
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
        XCCollectionAlignedFlowLayout *dcLayout = [[XCCollectionAlignedFlowLayout alloc] initWithAlignType:self.layoutType];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:dcLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blueColor];
        [_collectionView registerClass:[XCDefaultCollectionViewCell class] forCellWithReuseIdentifier:@"XCDefaultCollectionViewCell"];
        [_collectionView registerClass:[XCDefaultReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XCDefaultReusableView"];
    }
    return _collectionView;
}

@end
