//
//  BS_PersonWebController.m
//  BestNotSister
//
//  Created by huhang on 16/5/17.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PersonWebViewController.h"
#import "NJKWebViewProgress.h"

@interface BS_PersonWebViewController ()<UIWebViewDelegate>

//网页视图
@property (weak, nonatomic) IBOutlet UIWebView *webView;
//返回
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
//前进
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

//进度代理对象
@property (nonatomic,strong)NJKWebViewProgress *webProgress;

@end

@implementation BS_PersonWebViewController

/*
- (void)viewDidLoad{
 
    self.webProgress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.webProgress;
    __weak typeof(self) weakSelf = self;
    self.webProgress.progressBlock = ^(float progress){
      
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    
    };
   
    self.webProgress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
    
    NSLog(@"== %d",webView.canGoBack);
    NSLog(@"--- %d",webView.canGoForward);
}

#pragma mark 返回
- (IBAction)goBackAction:(id)sender {
    [self.webView goBack];
}

#pragma mark 前进
- (IBAction)goForwardAction:(id)sender {
    [self.webView goForward];
}

#pragma mark 刷新
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webProgress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.webProgress;
    __weak typeof(self) weakSelf = self;
    self.webProgress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.webProgress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
