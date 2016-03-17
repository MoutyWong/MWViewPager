//
//  ViewController.m
//  MWViewPager
//
//  Created by Mouty on 16/3/17.
//  Copyright © 2016年 Mouty. All rights reserved.
//

#import "ViewController.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * scroll;
@property (nonatomic,strong)UIPageControl * pageCtl;
@property (nonatomic,assign)NSInteger imgCount;
@property (nonatomic,assign)NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    self.imgCount = 5;
    [self createScrollView];
    [self createPage];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)autoScroll{
    [self reloadScrollWithIndex:-1];
}

- (void)createScrollView{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scroll.contentSize = CGSizeMake(kScreenWidth * 5, kScreenHeight);
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        NSString * imgName;
        if (i == 0) {
            imgName = [NSString stringWithFormat:@"%ld.jpg",i + 5];
        }else{
            imgName = [NSString stringWithFormat:@"%ld.jpg",i];
        }
        imgView.image = [UIImage imageNamed:imgName];
        imgView.tag = 2015 + i;
        [_scroll addSubview:imgView];
    }
    _scroll.contentOffset = CGPointMake(kScreenWidth, 0);
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
}

- (void)createPage{
    _pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, kScreenHeight - 30, 200, 30)];
    _pageCtl.currentPage = 1;
    _pageCtl.currentPageIndicatorTintColor = [UIColor purpleColor];
    _pageCtl.numberOfPages = 5;
    [self.view addSubview:_pageCtl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadScrollWithIndex:1];
}

- (void)reloadScrollWithIndex:(NSInteger)indexs{
    if (indexs != -1) {
        CGFloat offx = _scroll.contentOffset.x;
        if (offx > kScreenWidth) {
            _index = (_index + 1)%_imgCount;
        }else if(offx < kScreenWidth){
            _index = (_index + _imgCount -1)%_imgCount;
        }
    }else if(indexs == -1){
        _index = (_index + 1)%_imgCount;
    }
    UIImageView * imgView1 = (UIImageView *)[_scroll viewWithTag:2015];
    UIImageView * imgView2 = (UIImageView *)[_scroll viewWithTag:2016];
    UIImageView * imgView3 = (UIImageView *)[_scroll viewWithTag:2017];
    UIImageView * imgView4 = (UIImageView *)[_scroll viewWithTag:2018];
    UIImageView * imgView5 = (UIImageView *)[_scroll viewWithTag:2019];
    imgView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(_index + _imgCount -1)%_imgCount +1]];
    imgView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(_index +1)]];
    imgView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(_index +1)%_imgCount +1]];
    imgView4.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(_index +2)%_imgCount +1]];
    imgView5.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(_index +3)%_imgCount +1]];
    _scroll.contentOffset = CGPointMake(kScreenWidth, 0);
    _pageCtl.currentPage = _index%_imgCount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
