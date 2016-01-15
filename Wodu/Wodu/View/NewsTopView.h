//
//  NewsTopView.h
//  Wodu
//
//  Created by tenny on 15/12/28.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewsTopViewDelegate <NSObject>

- (void)didSelect:(NSInteger)pageIndex;

@end
@interface NewsTopView : UIView<UIScrollViewDelegate>
@property(nonatomic, weak) id<NewsTopViewDelegate> myDelegate;
@property(nonatomic, assign) NSInteger pageCount;
-(void) scrollToItem:(UILabel*)label;
@end
