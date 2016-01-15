//
//  NewsListCell.m
//  Wodu
//
//  Created by tenny on 16/1/3.
//  Copyright © 2016年 tenny. All rights reserved.
//

#import "NewsListCell.h"

@implementation NewsListCell

- (void)awakeFromNib {
    // Initialization code

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setCellData:(NewsListCellData *)data {
    self.titleLabel.text = data.title;
    self.descLabel.text = data.desc;
    if (data.imageUrl) {
        [self.imageUrl setImageWithURL:[NSURL URLWithString:data.imageUrl] placeholderImage:[UIImage imageNamed:@"NewsDefault"]];
    
    }

}

@end
