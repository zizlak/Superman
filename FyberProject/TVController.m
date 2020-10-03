//
//  TVController.m
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 03.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import "TVController.h"
#import "Order.h"

@interface TVController ()

@property (strong, nonatomic) NSMutableArray<Order *> *orders;

@end

@implementation TVController

NSString *cellId = @"cellid";



//MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orders = NSMutableArray.new;
    
    Order *order = Order.new;
    order.title = @"HHH";
    
    [self.orders addObject:order];
    
    self.navigationItem.title = @"List of Offers";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}




//MARK: Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    
    Order *order = self.orders[indexPath.row];
    cell.textLabel.text = order.title;
    return cell;
}

@end
