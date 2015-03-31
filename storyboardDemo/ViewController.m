//
//  ViewController.m
//  storyboardDemo
//
//  Created by pactera on 3/30/15.
//  Copyright (c) 2015 pactera. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()
{
    NSInteger rowCount;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    rowCount = 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * tableViewCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%f",tableViewCell.frame.size.height);
//    return tableViewCell.frame.size.height;
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell * cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    cell.cellIndex = indexPath;
    cell.callBlock = ^(BOOL isDelete,NSIndexPath *index)
    {
        if (isDelete)
        {
            
            [_tableView beginUpdates];
            rowCount--;
            [_tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
            [_tableView endUpdates];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
