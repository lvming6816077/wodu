//
//  NewsTopView.m
//  Wodu
//
//  Created by tenny on 15/12/28.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import "NewsTopView.h"
#import "Defines.h"
#import "NewsColumn.h"
@implementation NewsTopView
{
    UIScrollView *_scrollView;

}

-(instancetype) initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    [self initTopView];
    
    return self;

}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x, 0);

}
// top scrollView
-(void) initTopView{

    //    self.scrollView.frame = CGRectMake(0, 0, ScreenWidth, 36);
    //    CGRectOffset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>)
    //    CGRectInset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>)
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    NSArray *columnInfo = [NewsColumn columnInfo];
    NSInteger count = columnInfo.count;
    self.pageCount = count;
    for (int i = 0 ; i < count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * NewsColumnWidth, 0, NewsColumnWidth, NewsTopViewHeight)];
        
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.userInteractionEnabled = true;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)]];
        
        
        NewsColumn *co = columnInfo[i];
        [label setText:co.columnText];
        [label setTag:[co.columnId intValue]];
        
        
        if (i == 0) {
            label.textColor = [UIColor redColor];
            label.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
        }
        
        [_scrollView addSubview:label];
    }
    
    [_scrollView setTag:22];
    _scrollView.contentSize = CGSizeMake(count * NewsColumnWidth, NewsTopViewHeight);
    //    self.scrollView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = false;

    [self addSubview:_scrollView];
}
-(void) scrollToItem:(UILabel *)label {
    
    for (int i = 0; i < _scrollView.subviews.count; i++) {
        if ([_scrollView.subviews[i] isKindOfClass:[UILabel class]]) {
            UILabel *l = _scrollView.subviews[i];
            l.textColor = [UIColor blackColor];
            //            l.font = [UIFont systemFontOfSize:13];
            l.transform = CGAffineTransformIdentity;
        }
    }
    
    CGFloat scrollX = MIN(MAX(0, label.frame.origin.x - (ScreenWidth/2) + NewsColumnWidth/2),_scrollView.contentSize.width - ScreenWidth);
    
    
    
    [UIView animateWithDuration:.2 animations:^{
        label.textColor = [UIColor redColor];
        label.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
        _scrollView.contentOffset = CGPointMake(scrollX,0);
    } completion:^(BOOL finished) {
        [self.myDelegate didSelect:label.tag];
    }];
    

}
-(void) itemClick:(UITapGestureRecognizer*) recongizer {
    
    UILabel *label = (UILabel*)recongizer.view;
    [self scrollToItem:label];
    
}
@end


