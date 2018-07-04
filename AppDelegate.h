//
//  AppDelegate.h
//  BusSeatsBookingManagement
//
//  Created by admin on 04/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) int noOfColumnsAppDel;
@property (nonatomic) int noOfLevelsAppDel;
@property (nonatomic) int labelPositionAppDel;
@property(nonatomic,strong) NSMutableArray *selectedSeatsAppDel;
@property(nonatomic,strong) NSMutableArray *seatsListAppDel;

@end

