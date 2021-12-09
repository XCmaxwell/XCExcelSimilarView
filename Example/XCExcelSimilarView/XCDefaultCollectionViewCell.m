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
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.label.font = [UIFont systemFontOfSize:22];
        self.label.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end

@implementation XCDefaultReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

@end
