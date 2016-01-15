//
//  NewsBottomTableView.h
//  Wodu
//
//  Created by tenny on 15/12/31.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsBottomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *dataList;
-(void) fetchData:(NSString *) url;
@end
