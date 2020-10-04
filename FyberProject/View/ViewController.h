//
//  ViewController.h
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 02.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIDTF;
//@property (weak, nonatomic) NSString * appIDTFText;
-(void)signIn;

@end

