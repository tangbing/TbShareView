//
//  ViewController.m
//  TbShareView
//
//  Created by Tb on 2019/1/14.
//  Copyright © 2019 Tb. All rights reserved.
//

#import "ViewController.h"
#import "TbShareView.h"


@interface ViewController ()
@property (nonatomic, strong)TbShareView *shareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupShareView];
    
}

- (void)setupShareView
{
    self.shareView = [[TbShareView alloc] initShareViewToView:self.view title:@[@"微信好友",@"微信朋友圈",@"QQ好友",@"微新浪微博"] images:@[@"share_webchat",@"share_webchat_friendCircle",@"share_qq",@"share_weibo"] selectClick:^(NSUInteger selectFlag) {
        
        NSLog(@"selectFlag:%zd",selectFlag);
    }];
    [self.shareView show];
}



@end
