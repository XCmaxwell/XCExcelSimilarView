//
//  XCViewController.m
//  XCExcelSimilarView
//
//  Created by xuecheng wang on 08/27/2021.
//  Copyright (c) 2021 xuecheng wang. All rights reserved.
//

#import "XCViewController.h"
#import "XCDefaultCollectionViewCell.h"
#import "XCCollectionAlignedFlowLayout.h"

@interface XCViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSArray *> *dataArray;
@end

@implementation XCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.dataArray =@[
    @[@"汉字",@"厚",@"汉族",@"度啊",@"哈哈哈",@"音乐",@"音乐",@"开发者巴基斯坦",@"印度",@"大不列颠及北爱尔兰",@"度啊",@"哈哈哈",@"音乐",@"哈",@"澳大利亚"],
    @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度",@"大不及北爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚"],
    @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度",@"大不及北爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚"],
    @[@"汉字",@"厚dsf;ds",@"汉族",@"度dsf啊",@"哈",@"音乐",@"音乐",@"开发坦",@"印度",@"大不及北爱尔兰",@"度dsfdf第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚",@"ali辅导老师"],
    @[@"汉字",@"厚第三方s",@"汉族",@"度第三方",@"哈",@"音乐地方",@"音乐",@"开二发坦",@"印度",@"大不及热火以北爱尔兰",@"度热给他扔第三方啊",@"哈哈哈",@"音长度乐",@"哈sads",@"澳大利亚",@"哈",@"澳大利亚",@"音长度乐",@"哈迪斯",@"澳大",@"出国的"],
   ];
//    @[@"汉字",@"厚度啊",@"汉族",@"中华名族",@"中华人民共和国",@"劳动法",@"团结统一",@"撒旦撒旦",@"汉族",@"中华名族",@"中华人民共和国",@"音乐",@"华府倾向",@"三清殿",@"月色",@"开发者巴基斯坦",@"印度",@"大不列颠及北爱尔兰",@"澳大利亚"]
    [self.collectionView reloadData];
    
//    UILabel *label = [UILabel new];
//    label.textColor = [UIColor redColor];
//    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
//    NSString *eee = @"UILabelsadsgaldsagfGUDG;SGV;DOSGVDG;OS;GDO;SDSGFDUS;";
//    label.text = eee;
//    CGRect rect = [eee boundingRectWithSize:CGSizeMake(100, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
//    [self.view addSubview:label];
//    label.frame = CGRectMake(100, 100, rect.size.width, rect.size.height);
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [NSString stringWithFormat:@"%d-%d%@",indexPath.row, indexPath.section, self.dataArray[indexPath.section][indexPath.row]];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:22]};
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attrs context:nil];
    return CGSizeMake(rect.size.width, rect.size.height);
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
     cell.label.text = self.dataArray[indexPath.section][indexPath.row];
//     [NSString stringWithFormat:@"%d-%d%@",indexPath.row, indexPath.section, self.dataArray[indexPath.section][indexPath.row]];
     cell.label.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
     cell.backgroundColor = [UIColor redColor];
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

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 100.f;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 30.f;
//}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XCCollectionAlignedFlowLayout *dcLayout = [[XCCollectionAlignedFlowLayout alloc] initWithAlignType:XCCollectionViewAlignedLayoutLeft];
//        dcLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        dcLayout.sectionInset = UIEdgeInsetsMake(20, 25, 20, 25);
        dcLayout.minimumLineSpacing = 10.f;
        dcLayout.minimumInteritemSpacing = 40.f;
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
