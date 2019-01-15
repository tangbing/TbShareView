//
//  TbShareView.h
//  Epipe
//
//  Created by Tb on 2018/1/30.
//  Copyright © 2018年 Epipe-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbShareView : UIView
- (instancetype)initShareViewToView:(UIView *)toView title:(NSArray *)titles images:(NSArray *)images selectClick:(void(^)(NSUInteger))selectClick;
- (void)show;
- (void)hide;
@end
