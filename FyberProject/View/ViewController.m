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
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showOffer"]) {
        
        TVController * tvc = [segue destinationViewController];
        tvc.appID = self.idTextField.text;
        tvc.userID = self.userIDTF.text;

        
    }
}
- (IBAction)buttonAction:(UIButton *)sender {
    [self signIn];
}

-(void)signIn {
    [self performSegueWithIdentifier:@"showOffer" sender:self];
}

@end
