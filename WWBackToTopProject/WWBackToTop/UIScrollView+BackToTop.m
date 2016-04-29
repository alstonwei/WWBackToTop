//
//  UIScrollView+BackToTop.m
//  
//
//  Created by weishouqiang on 16/4/28.
//  Copyright © 2016年 weishouqiang. All rights reserved.
//

#import "UIScrollView+BackToTop.h"
#import <objc/runtime.h>

const void * WWUIScrollViewBackToTopKey = "WWUIScrollViewBackToTopKey";
NSString * const WWBackToTopButtonKey = @"ww_backToTopButton";
NSString * const WWBackToTopKeyPathContentOffset = @"contentOffset";



@interface WWBackToTopButton()


@end
@implementation WWBackToTopButton


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self removeObservers];
    if (newSuperview) {
        _scrollview = (UIScrollView*)newSuperview;
        CGFloat parentw  = CGRectGetWidth(self.scrollview.bounds);
        CGFloat parenth  = CGRectGetHeight(self.scrollview.bounds);
        CGFloat itemSize = 52,rightPadiing = 30,bottomPadding = 80;
        CGFloat x = parentw - itemSize - rightPadiing;
        CGFloat y = parenth - itemSize - bottomPadding;
        [self.superview bringSubviewToFront:self];
        self.frame = CGRectMake(x,y,itemSize ,itemSize);
        [self addObservers];
    }
}

- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollview addObserver:self forKeyPath:WWBackToTopKeyPathContentOffset options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:WWBackToTopKeyPathContentOffset];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if (self.scrollview.contentOffset.y > 0.5*CGRectGetHeight(self.scrollview.bounds)) {
        [self setHidden:NO];
        
        CGFloat parentw  = CGRectGetWidth(self.scrollview.bounds);
        CGFloat parenth  = CGRectGetHeight(self.scrollview.bounds);
        CGFloat itemSize = 52,rightPadiing = 30,bottomPadding = 80;
        CGFloat x = parentw - itemSize - rightPadiing;
        CGFloat y = parenth - itemSize - bottomPadding;
        y +=self.scrollview.contentOffset.y;
        NSLog(@"y = %f",y);
        self.frame = CGRectMake(x,y,itemSize ,itemSize);
    }
    else
    {
        [self setHidden:YES];
 
    }
 
}

@end

@implementation UIScrollView (BackToTop)


- (UIButton *)ww_backToTopButton{
    return objc_getAssociatedObject(self, &WWUIScrollViewBackToTopKey);
}

- (void)setWw_backToTopButton:(WWBackToTopButton *)ww_backToTopButton
{
    if (ww_backToTopButton != self.ww_backToTopButton) {
        [self.ww_backToTopButton removeFromSuperview];
        self.ww_backToTopButton.scrollview = self;
        [self.ww_backToTopButton setHidden:YES];
        [self addSubview:ww_backToTopButton];
        
        [self willChangeValueForKey:WWBackToTopButtonKey];
        objc_setAssociatedObject(self, &WWUIScrollViewBackToTopKey,
                                 ww_backToTopButton, OBJC_ASSOCIATION_RETAIN);
        [self didChangeValueForKey:WWBackToTopButtonKey];
    }
}



- (void)ww_addBackToTopButton
{
   WWBackToTopButton* btn = [WWBackToTopButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"btn_back_to_top"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backToTop:) forControlEvents:UIControlEventTouchUpInside];
    [self setWw_backToTopButton:btn];
}

-(void)backToTop:(id)sender
{
    NSLog(@"backToTop");
    //[self scrollsToTop];
    
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
