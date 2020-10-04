//
//  ViewController.m
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 02.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import "ViewController.h"
#import "TVController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *iDTextField;
@property (weak, nonatomic) IBOutlet UITextField *tokenTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showOffer"]) {
        
        TVController * tvc = [segue destinationViewController];
        tvc.appID = self.iDTextField.text;
        tvc.token = self.tokenTextField.text;
        NSLog(self.tokenTextField.text);
    }
}


@end
