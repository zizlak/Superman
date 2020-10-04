//
//  TVController.m
//  FyberProject
//
//  Created by Aleksandr Kurdiukov on 03.10.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

#import "TVController.h"
#import "Offer.h"
#import "Cell.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/xattr.h>

//MARK: Hash SHA1
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

//MARK: Interface
@interface TVController ()
@property (strong, nonatomic) NSMutableArray<Offer *> *offers;
@end

//MARK: TVController
@implementation TVController
@synthesize appID, userID;

//MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData];
    
    self.navigationItem.title = @"List of Offers";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}


//MARK: fetchData
-(void) fetchData {
    
    //MARK: URLString
    NSString *http = @"http://api.fyber.com/feed/v1/offers.json?";
    NSString *string0 = @"appid=";
    string0 = [string0 stringByAppendingString:appID];
    string0 = [string0 stringByAppendingString:@"&ip=109.235.143.113&locale=de&timestamp="];
    
    NSString *date = [NSString stringWithFormat:@"%lu", (long)[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue]];
    
    NSString *string = [string0 stringByAppendingString:date];
    string = [string stringByAppendingString:@"&uid="];
    string = [string stringByAppendingString:userID];
    
    NSString *stringWithToken = [string stringByAppendingString:@"&1c915e3b5d42d05136185030892fbb846c278927"];
    NSString *hash = stringWithToken.sha1;
    
    string = [http stringByAppendingString:string];
    string = [string stringByAppendingString:@"&hashkey="];
    string = [string stringByAppendingString:hash];

    
    //MARK: URLSession
    NSURL *url = [NSURL URLWithString:string];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"URLSession Request failed: %@", error);
            
            [self returnEmptyTable];
            return;
        }
        
        //MARK: Signature
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
            NSDictionary *dictionary = [httpResponse allHeaderFields];
            
            NSString *signature = dictionary[@"X-Sponsorpay-Response-Signature"];
            
            NSString *hashedResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            hashedResponse = [hashedResponse stringByAppendingString:@"1c915e3b5d42d05136185030892fbb846c278927"];
            hashedResponse = hashedResponse.sha1;
            
            if (![hashedResponse isEqual:signature]){
                NSLog(@"Response is not valid; Signature mismatch problem");
                [self returnEmptyTable];
                return;
            }
        }
        
        //MARK: JSON
        NSError *err;
        NSDictionary *offersJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err) {
            NSLog(@"JSON Serialization Failed: %@", err);
            [self returnEmptyTable];
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
        }
        
    }]resume];
}

//MARK: Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.offers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Cell *cell = Cell.new;
    if (cell = (UITableViewCell *)cell0) {
    
    Offer *offer = self.offers[indexPath.row];
    
    cell.labelCell.text = offer.title;
    cell.imageOffer.image = [[UIImage alloc] initWithData:offer.picData];
    cell.labelCell.adjustsFontSizeToFitWidth = true;
    
    return cell;
    } else {
        return UITableViewCell.new;
    }
}

//MARK: returnEmptyTableView
- (void) returnEmptyTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray <Offer *> *empty = NSMutableArray.new;
        self.offers = empty;
        [self.tableView reloadData];
    });
}

@end
