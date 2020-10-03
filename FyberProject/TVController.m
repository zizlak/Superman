//
//  TVController.m
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 03.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import "TVController.h"

@interface TVController ()

@end

@implementation TVController

NSString *cellId = @"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"List of Offers";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    cell.textLabel.text = @"\(indexPath.row)";
    return cell;
}

@end
