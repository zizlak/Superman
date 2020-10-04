//
//  Cell.h
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 04.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelCell;
@property (weak, nonatomic) IBOutlet UIImageView *imageOffer;

@end

NS_ASSUME_NONNULL_END
