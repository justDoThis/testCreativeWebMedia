//
//  EZDetailPostViewController.m
//  testCreativeWebmedia
//
//  Created by Egor Zemlyanskiy on 19.02.16.
//  Copyright © 2016 EZ. All rights reserved.
//

#import "EZDetailPostViewController.h"

@interface EZDetailPostViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)EZPost * post;
@property (nonatomic, strong)IBOutlet UIWebView * detailWebView;
@property (nonatomic, strong)IBOutlet UIActivityIndicatorView * act;

@end

@implementation EZDetailPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Detail Post";
    
    [self.detailWebView loadHTMLString:[_post getHTMLStringFromPost] baseURL:nil];
    
    // Do any additional setup after loading the view.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_act stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [_act startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupPost:(EZPost*)post
{
    _post = post;
}

@end
