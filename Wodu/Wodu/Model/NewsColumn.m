//
//  NewsColumn.m
//  Wodu
//
//  Created by tenny on 15/12/28.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import "NewsColumn.h"

@implementation NewsColumn
-(instancetype) initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}
+(NSArray*) columnInfo {
    
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"ColumnItem" ofType:@"plist"];
    NSArray *columnConfigs = [NSArray arrayWithContentsOfFile:configFile];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:columnConfigs.count];
    
    for (int i = 0; i < columnConfigs.count; i++) {
        NewsColumn *co = [[NewsColumn alloc] initWithDict:columnConfigs[i]];
        [arr addObject:co];
    }
    
    return arr;
}
@end
