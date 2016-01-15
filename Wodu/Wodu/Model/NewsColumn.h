//
//  NewsColumn.h
//  Wodu
//
//  Created by tenny on 15/12/28.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsColumn : NSObject
@property(nonatomic,strong) NSString *columnId;
@property(nonatomic,strong) NSString *columnText;
-(instancetype) initWithDict:(NSDictionary *) dict;;
+(NSArray *) columnInfo;
@end
