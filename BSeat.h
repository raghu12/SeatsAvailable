//
//  BSeat.h
//  BusSeatsBookingManagement
//
//  Created by admin on 04/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSeat : UIButton

@property (nonatomic) int row;
@property (nonatomic) int column;
@property (nonatomic) BOOL available;
@property (nonatomic) BOOL disabled;
@property (nonatomic) BOOL selected_seat;
@property (nonatomic) float price;

@end
