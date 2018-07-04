//
//  ViewController.h
//  BusSeatsBookingManagement
//
//  Created by admin on 04/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSeatSelector.h"
#import "BSeat.h"

@interface ViewController : UIViewController <BSeatSelectorDelegate>
{
    AppDelegate *delegate;
}
@property(nonatomic,strong) NSMutableArray *seatsList;
@property (nonatomic) int noOfValues;

@end

