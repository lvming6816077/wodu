//
//  NewsViewController.m
//  Wodu
//
//  Created by tenny on 15/12/26.
//  Copyright © 2015年 tenny. All rights reserved.
//

#import "NewsViewController.h"
#import "Defines.h"
#import "NewsBottomTableView.h"


@interface NewsViewController ()

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) NewsTopView *newsTopScrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) UIScrollView  *newsBottomScrollView;
@property (assign, nonatomic) BOOL isScrolling;
@property (strong, nonatomic) NSMutableArray<NewsBottomTableView *>  *tableviews;
@end


@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    
    [self initNavBtn];

    
}
- (void)viewDidAppear:(BOOL)animated
{
    
    // should ues viewDidAppear function
    [super viewDidAppear:animated];
    if (self.newsTopScrollView == nil) {
        [self initTopView];
    }
    if (self.newsBottomScrollView == nil) {
            [self initBottomView];
    }
    



}
- (void) initNavBtn{
    
    // set left btn
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavigationBell"] style:UIBarButtonItemStylePlain target:self action:nil];
    btnLeft.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    //set right btn
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavigationSquare"] style:UIBarButtonItemStylePlain target:self action:nil];
    btnRight.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = btnRight;
    
}
-(void)initTopView {


        self.newsTopScrollView = [[NewsTopView alloc] initWithFrame:self.topView.bounds];
        self.newsTopScrollView.myDelegate = self;
        [self.topView addSubview:self.newsTopScrollView];
//        [self.topView bringSubviewToFront:topScrollView];
//        [self.topView sendSubviewToBack:self.scrollView];


    
}
-(void)initBottomView {
    NSInteger count = self.newsTopScrollView.pageCount;
//
    self.newsBottomScrollView = [[UIScrollView alloc] init];
    self.newsBottomScrollView.delegate = self;
    self.newsBottomScrollView.frame = self.bottomView.bounds;
    for (int i = 0; i<count; i++) {
        CGRect frame = CGRectMake((self.bottomView.bounds.origin.x+self.bottomView.bounds.size.width) * i, self.bottomView.bounds.origin.y, self.bottomView.bounds.size.width, self.bottomView.bounds.size.height);
        NewsBottomTableView *table = [[NewsBottomTableView alloc] initWithFrame:frame];
        [self.newsBottomScrollView addSubview:table];
        if (i == 0) {
            [table fetchData:@"0"];
        }
    }
    self.newsBottomScrollView.backgroundColor = [UIColor whiteColor];
    self.newsBottomScrollView.contentSize = CGSizeMake(count*self.bottomView.frame.size.width, 0);
    self.newsBottomScrollView.pagingEnabled = true;
    [self.bottomView addSubview:self.newsBottomScrollView];
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!self.isScrolling) {
        self.isScrolling = true;
    }
    
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate) {
//        if (self.isScrolling) {
//            self.isScrolling = false;
//            [self changePage:scrollView];
//        }
//
//    }
//}
- (void) changePage:(UIScrollView *)scrollView{

    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    UILabel *label = (UILabel*)[self.newsTopScrollView viewWithTag:page+1];
    [self.newsTopScrollView scrollToItem:label];
//    if (scrollView == self.tableview) {
//        
//    }
    NewsBottomTableView *current = [self.newsBottomScrollView subviews][page];
    
    [current fetchData:[NSString stringWithFormat:@"%d",page]];
//    NSLog(@"%d",page);
}
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.isScrolling) {
        self.isScrolling = false;
        [self changePage:scrollView];
    }
    
//    if(page == 1) {
//        return;
//    } else if (page == 0) {
////        [self pageMoveToRight];
//    } else {
////        [self pageMoveToLeft];
//    }
//    
//    CGPoint p = CGPointZero;
//    p.x = pageWidth;
//    [scrollView setContentOffset:p animated:NO];
//    NSInteger w = self.bottomView.bounds.size.width;
//    NSInteger c = MAX((float)scrollView.contentOffset.x, 0);
////    NSLog(@"%d",c);
////    NSLog(@"%d",w);
//    NSLog(@"%d",c%w);
//    [scrollView setContentOffset:CGPointMake(0, 0) animated:true];// = CGPointMake(c / w * w, 0);
//    if (c % w <= w*0.5) {
//        NSLog(@"%@",@"FFF");
//        
//    } else {
//        NSLog(@"%@",@"XXX");
////        [scrollView setContentOffset:CGPointMake(((int)(c / w)+1) * w, 0) animated:true];
//    }
}
-(void) didSelect:(NSInteger)pageIndex {

    pageIndex = pageIndex - 1;
    [self.newsBottomScrollView setContentOffset:CGPointMake(pageIndex*self.bottomView.bounds.size.width, 0) animated:true];
//    NSLog(@"%ld",(long)pageIndex);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
