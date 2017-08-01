//
//  TWOViewController.m
//  WebViewDemo
//
//  Created by chenbowen on 2017/6/27.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "TWOViewController.h"
#import "DDProgressView.h"

@interface TWOViewController ()<UIWebViewDelegate>

@property(strong,nonatomic)DDProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TWOViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.title = @"api/cookies/write";
    
    
    self.webView.delegate = self;
    //    self.webView.scalesPageToFit = YES;
    
    }

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSString *url = @"https://gatewaytest.qianduan.com/api/cookies/write";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
}
- (IBAction)refreshAction:(id)sender {
    
      [self.webView reload];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [self.progressView startColorful];
    
    return  YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (self.progressView.superview == nil) {
        UINavigationController *nav = self.navigationController;
        [nav.view addSubview:self.progressView];
    }
    [self.progressView startColorful];
    [self.progressView setProgress:0.9 duation:2 animated:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.progressView setProgress:1.0];
    [self performSelector:@selector(removeLoadingView) withObject:nil afterDelay:0.5f];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark - 进度条停止
-(void)removeLoadingView{
    [self.progressView stopColorful];
}


-(DDProgressView *)progressView{
    
    if (_progressView == nil) {
        
        _progressView = [[DDProgressView alloc] initWithFrame:(CGRect){0,64,[UIScreen mainScreen].bounds.size.width,2} backGroundColor:[UIColor blueColor]];
        
        UINavigationController *nav = self.navigationController;
        [nav.view addSubview:_progressView];
        
    }
    return _progressView;
}



@end
