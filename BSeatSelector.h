//
//  BSeatSelector.h
//  BusSeatsBookingManagement
//
//  Created by admin on 04/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSeat.h"
#import "AppDelegate.h"

@class BSeatSelector;
@protocol BSeatSelectorDelegate <NSObject>
- (void)seatSelected:(BSeat *)seat;
@optional
- (void)getSelectedSeats:(NSMutableArray *)seats;
@end

@interface BSeatSelector : UIScrollView <UIScrollViewDelegate>{
    float seat_width;
    float seat_height;
    NSMutableArray *selected_seats;
    UIView *zoomable_view;
    AppDelegate *delegate;
}

@property (nonatomic, retain) UIImage *available_image;
@property (nonatomic, retain) UIImage *unavailable_image;
@property (nonatomic, retain) UIImage *disabled_image;
@property (nonatomic, retain) UIImage *selected_image;
@property (nonatomic, retain) UIImage *ladiesseat_image;

@property (nonatomic, retain) UIImage *steering_image;

@property (nonatomic) int selected_seat_limit;

@property (nonatomic) float seat_price;
@property (retain) id seat_delegate;

-(void)setSeatSize:(CGSize)size;

- (void)setSeatsAtPosition:(NSString*)seatString;

-(void)setAvailableImage:(UIImage*)available_image andUnavailableImage:(UIImage*)unavailable_image andDisabledImage:(UIImage*)disabled_image andSelectedImage:(UIImage*)selected_image andSteeringImage:(UIImage*)steering_image andladiesseatImage:(UIImage*)ladiesseat_image;



@end
