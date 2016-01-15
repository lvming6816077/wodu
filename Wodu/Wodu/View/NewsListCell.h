//
//  NewsListCell.h
//  Wodu
//
//  Created by tenny on 16/1/3.
//  Copyright © 2016年 tenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListCellData.h"
#import "UIKit+AFNetworking.h"
@interface NewsListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
-(void)setCellData:(NewsListCellData*)data;

@end
