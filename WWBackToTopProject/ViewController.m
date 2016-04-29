//
//  ViewController.m
//  WWBackToTopProject
//
//  Created by epailive on 16/4/29.
//  Copyright © 2016年 weishouqiang. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+BackToTop.h"

@interface ViewController ()<UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView ww_addBackToTopButton];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"WWCustomCell"];
    
    if (cell) {
        UIImageView* imageView = [cell.contentView viewWithTag:100];
        if (imageView) {
            [imageView setImage:[UIImage imageNamed:[@(indexPath.row%7) description]]];
        }
    }
    return cell;
}

@end
