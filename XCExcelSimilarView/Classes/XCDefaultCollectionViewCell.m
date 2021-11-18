//
//  XCDefaultCollectionViewCell.m
//  XCExcelSimilarView
//
//  Created by MINI-01 on 2021/11/16.
//

#import "XCDefaultCollectionViewCell.h"

@implementation XCDefaultCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.label = [UILabel new];
        self.label.frame = CGRectMake(10, 0, 50, 50);
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end

@implementation XCDefaultReusableView

@end
