//
//  NewsListCellData.h
//  Wodu
//
//  Created by tenny on 16/1/3.
//  Copyright © 2016年 tenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListCellData : NSObject
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *desc;
-(instancetype) initWithDict:(NSDictionary *)dict;
@end
