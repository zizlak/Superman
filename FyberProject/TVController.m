//
//  TVController.m
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 03.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import "TVController.h"
#import "Offer.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/xattr.h>

//MARK: HASH SHA1
@implementation NSString (reverse)
-(NSString*)sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
@end


@interface TVController ()

@property (strong, nonatomic) NSMutableArray<Offer *> *offers;

@end

@implementation TVController

@synthesize appID, token;

NSString *cellId = @"cellid";


//MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpOffers];
    
    NSLog(self.appID);
    
    [self fetchData];
    
    self.navigationItem.title = @"List of Offers";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}

//MARK: fetchData
-(void) fetchData {
    
    //MARK: URLString
    NSString *http = @"http://api.fyber.com/feed/v1/offers.json?";
    NSString *string0 = @"appid=2070&google_ad_id=a0b0c0d0-a0b0-c0d0-e0f0-a0b0c0d0e0f0&google_ad_id_limited_tracking_enabled=true&ip=109.235.143.113&locale=de&page=2&pub0=campaign2&timestamp=";
    
    NSString *date = [NSString stringWithFormat:@"%lu", (long)[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue]];
    
    NSString *string = [string0 stringByAppendingString:date];
    string = [string stringByAppendingString:@"&uid=superman"];
    
    NSString *stringWithToken = [string stringByAppendingString:@"&1c915e3b5d42d05136185030892fbb846c278927"];
    NSString *hash = stringWithToken.sha1;
    
    string = [http stringByAppendingString:string];
    string = [string stringByAppendingString:@"&hashkey="];
    string = [string stringByAppendingString:hash];
    
    //MARK: URLSession
    NSURL *url = [NSURL URLWithString:string];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //   NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //   NSLog(@"Dummy String: %@", dummyString);
        
        NSError *err;
        NSDictionary *offersJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err) {
            NSLog(@"JSON Serialization Failed: %@", err);
            return;
        }
        NSArray *offers = offersJSON[@"offers"];
        NSMutableArray <Offer *> *offersJSONArray = NSMutableArray.new;
        for (NSDictionary *item in offers) {
            NSDictionary *tmbn = item[@"thumbnail"];
            
            Offer *offer = Offer.new;
            offer.title = item[@"title"];
            NSString *picURLString = tmbn[@"lowres"];
            NSURL *picURL = [NSURL URLWithString:picURLString];
            
            [[NSURLSession.sharedSession dataTaskWithURL: picURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       
                dispatch_async(dispatch_get_main_queue(), ^{
                    offer.picData = data;
                    [self.tableView reloadData];
                });
                
               }]resume];
            
            [offersJSONArray addObject:offer];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.offers = offersJSONArray;
                [self.tableView reloadData];
            });
            
        //    NSLog(@"%@", offersJSONArray);
        }
        
    }]resume];
}

//MARK: setUpOffers
-(void) setUpOffers {
    self.offers = NSMutableArray.new;
    
    Offer *offer = Offer.new;
    offer.title = @"Title";
    
    [self.offers addObject:offer];
}


//MARK: Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.offers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    cell.backgroundColor = UIColor.grayColor;
    
    Offer *offer = self.offers[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = true;
    cell.textLabel.text = offer.title;
    cell.imageView.image = [[UIImage alloc] initWithData:offer.picData];
    
    return cell;
}

@end




