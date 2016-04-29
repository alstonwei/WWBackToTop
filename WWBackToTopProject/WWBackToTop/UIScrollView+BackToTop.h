//
//  UIScrollView+BackToTop.h
//
//
//  Created by weishouqiang on 16/4/28.
//  Copyright © 2016年 weishouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWBackToTopButton : UIButton

@property(nonatomic,assign)UIScrollView* scrollview;

@end

@interface UIScrollView (BackToTop)

@property(nonatomic,strong) WWBackToTopButton* ww_backToTopButton;

- (void)ww_addBackToTopButton;

@end
