//
//  Order.h
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 03.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Offer : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSData *picData;

@end

NS_ASSUME_NONNULL_END
