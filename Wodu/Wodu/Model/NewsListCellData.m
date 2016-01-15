//
//  NewsListCellData.m
//  Wodu
//
//  Created by tenny on 16/1/3.
//  Copyright © 2016年 tenny. All rights reserved.
//

#import "NewsListCellData.h"

@implementation NewsListCellData
-(instancetype) initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}
@end
