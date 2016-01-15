//
//  NewsBottomTableView.m
//  Wodu
//
//  Created by tenny on 15/12/31.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import "NewsBottomTableView.h"
#import "NewsListCell.h"
#import "NewsListCellData.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
@implementation NewsBottomTableView
{
    NSDictionary *_cgiData;
    NSDictionary *_params;
    NSString *_currentUrl;
}


-(void) fetchData:(NSString*)url {
    
    _currentUrl = url;
    _cgiData = @{
                 @"0" : @"10040",
                 @"1" : @"10364",
                 @"2" : @"11022",
                 @"3" : @"208965",
                 @"4" : @"10415",
                 @"5" : @"24045",
                 @"6" : @"10179",
                 @"7" : @"10072",
                 @"8" : @"10040"
                 };
    
    NSString *urlParams = @"";
    for (NSString *key in _params) {

        urlParams = [NSString stringWithFormat:@"%@&%@=%@",urlParams,key,_params[key]];
    }
    
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"http://buluo.qq.com/cgi-bin/bar/post/get_post_by_page?bid=%@%@",_cgiData[url],urlParams];
    
    
    
//    NSString *urlStr = [@"http://buluo.qq.com/cgi-bin/bar/post/get_post_by_page?bid=10364&start=0&num=10" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSMutableURLRequest *m = [request mutableCopy];
//    [m addValue:@"http://buluo.qq.com/" forHTTPHeaderField:@"Referer"];
//    request = [m copy];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(jsonString);
//    }];
    
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"http://buluo.qq.com/" forHTTPHeaderField:@"Referer"];
    [manager GET:requestUrl
      parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

          NSArray *arr = [[responseObject valueForKeyPath:@"result"] valueForKey:@"posts"];
          NSLog(@"%d",arr.count);
          [self.mj_header endRefreshing];
          [self.mj_footer endRefreshing];
          NSMutableArray *result = [NSMutableArray array];
          for (int i = 0; i<arr.count ; i++) {
              NSDictionary *dic = arr[i];
              NewsListCellData *ncd = [[NewsListCellData alloc] init];
              ncd.title = dic[@"title"];
              ncd.desc = dic[@"post"][@"content"];
              
              if (dic[@"post"][@"pic_list"]) {
                  NSArray *arr = dic[@"post"][@"pic_list"];
                  
                  if (arr.count > 1) {
                      NSDictionary *dd = arr[0];
                      NSString *imageUrl = dd[@"url"];
                      if ([imageUrl hasSuffix:@"/0"]) {
                          [imageUrl stringByReplacingOccurrencesOfString:@"/0" withString:@"/200"];
                      }

                      ncd.imageUrl = imageUrl;
                      [result addObject:ncd];
                      
                  }
                
              }
              
          }
          if (self.dataList == nil) {
              
//              self.dataList = [NSMutableArray array];
              
              self.dataList = result;
          } else {
              self.dataList = (NSMutableArray*)[self.dataList arrayByAddingObjectsFromArray:result];
          }
          [self reloadData];

          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
      }];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}

-(instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        _params = @{@"start": @"0",
                    @"num": @"10"
                    };

        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _params = @{@"start": @"0",
                        @"num": @"10"
                        };
            self.dataList = nil;
            [self fetchData:_currentUrl];
            
        }];
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            int pageStart = [_params[@"start"] intValue]+10;
            
            _params = @{@"start": [NSString stringWithFormat:@"%d",pageStart],
                        @"num": @"10"
                        };
//            [_params setValue:@"10" forKey:@"start"];
            
            [self fetchData:_currentUrl];

            [self.mj_footer endRefreshing];
        }];
    
    }

    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NewsListCellData *currentData = self.dataList[indexPath.row];
    NSString *cellIdentifier = @"NewsListCell";
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {

        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:tableView options:nil];
        cell = [Objects objectAtIndex:0];
    }
    

    [cell setCellData:currentData];

    return cell;
}

@end
