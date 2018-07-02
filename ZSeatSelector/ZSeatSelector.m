//
//  ZSeatSelector.m
//  
//
//  Created by Ricardo Zertuche on 7/30/15.
//
//

#import "ZSeatSelector.h"

@implementation ZSeatSelector

#pragma mark - Init and Configuration

- (void)setSeatSize:(CGSize)size{
    seat_width = size.width;
    seat_height = size.height;
}
- (void)setMap:(NSString*)map{
    
    self.delegate = self;
    zoomable_view = [[UIView alloc]init];
    
    int initial_seat_x = 0;
    int initial_seat_y = 0;
    int final_width = 0;
    
    for (int i = 0; i<map.length; i++) {
        char seat_at_position = [map characterAtIndex:i];
        
         if (seat_at_position == 'E') {
            [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:FALSE isDisabled:TRUE andConditionString:@"E"];
            initial_seat_x += 1;
            
        }else if (seat_at_position == 'A') {
            [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:TRUE isDisabled:FALSE andConditionString:@"A"];
            initial_seat_x += 1;
            
        }else if (seat_at_position == 'L') {
            [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:TRUE isDisabled:FALSE andConditionString:@"L"];
            initial_seat_x += 1;
            
        } else if (seat_at_position == 'D') {
            [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:TRUE isDisabled:TRUE andConditionString:@"D"];
            initial_seat_x += 1;
            
        } else if (seat_at_position == 'U') {
            [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:FALSE isDisabled:FALSE andConditionString:@"U"];
            initial_seat_x += 1;
            
        }  else if(seat_at_position=='_'){
            initial_seat_x += 1;
            
        } else {
            if (initial_seat_x>final_width) {
                final_width = initial_seat_x;
            }
            initial_seat_x = 0;
            initial_seat_y += 1;
        }
    }
    
    //zoomable_view.frame = CGRectMake(0, 0, final_width*seat_width, initial_seat_y*seat_height);
    
    zoomable_view.frame = CGRectMake(0, 15, self.frame.size.width, 180);
    
    [self setContentSize:zoomable_view.frame.size];
   // CGFloat newContentOffsetX = (self.contentSize.width - self.frame.size.width) / 2;
   // self.contentOffset = CGPointMake(newContentOffsetX, 0);
    selected_seats = [[NSMutableArray alloc]init];
    //[self setBackgroundColor:[UIColor blueColor]];
    [self addSubview:zoomable_view];
    
}
- (void)createSeatButtonWithPosition:(int)initial_seat_x and:(int)initial_seat_y isAvailable:(BOOL)available isDisabled:(BOOL)disabled{
    
    ZSeat *seatButton = [[ZSeat alloc]initWithFrame:
                         CGRectMake(initial_seat_x*seat_width,
                                    initial_seat_y*seat_height,
                                    seat_width,
                                    seat_height)];
    if (!available && disabled) {
        [self setSteering:seatButton];
        //return;
    } else if (available && disabled) {
        [self setSeatAsDisabled:seatButton];
    } else if (available && !disabled) {
        [self setSeatAsAvaiable:seatButton];
    } else {
        [self setSeatAsUnavaiable:seatButton];
    }
    [seatButton setAvailable:available];
    [seatButton setDisabled:disabled];
    [seatButton setRow:initial_seat_y+1];
    [seatButton setColumn:initial_seat_x+1];
    [seatButton setPrice:self.seat_price];
    [seatButton addTarget:self action:@selector(seatSelected:) forControlEvents:UIControlEventTouchDown];
    [zoomable_view addSubview:seatButton];
    
}

- (void)createSeatButtonWithPosition:(int)initial_seat_x and:(int)initial_seat_y isAvailable:(BOOL)available isDisabled:(BOOL)disabled andConditionString:(NSString*)conditionString{
    
    ZSeat *seatButton = [[ZSeat alloc]initWithFrame:
                         CGRectMake(initial_seat_x*seat_width,
                                    initial_seat_y*seat_height,
                                    seat_width,
                                    seat_height)];
    if (!available && disabled && [conditionString isEqualToString:@"E"]) {
        [self setSteering:seatButton];
        //return;
    } else if (available && disabled && [conditionString isEqualToString:@"D"]) {
        [self setSeatAsDisabled:seatButton];
    } else if (available && !disabled && [conditionString isEqualToString:@"A"]) {
        [self setSeatAsAvaiable:seatButton];
    } else if (!available && !disabled && [conditionString isEqualToString:@"U"]) {
        [self setSeatAsUnavaiable:seatButton];
    }else if (available && !disabled && [conditionString isEqualToString:@"L"]) {
        [self setLadiesSeatAsAvaiable:seatButton];
    }
    [seatButton setAvailable:available];
    [seatButton setDisabled:disabled];
    [seatButton setRow:initial_seat_y+1];
    [seatButton setColumn:initial_seat_x+1];
    [seatButton setPrice:self.seat_price];
    [seatButton addTarget:self action:@selector(seatSelected:) forControlEvents:UIControlEventTouchDown];
    [zoomable_view addSubview:seatButton];
    
}




#pragma mark - Seat Selector Methods

- (void)seatSelected:(ZSeat*)sender{
    if (!sender.selected_seat && sender.available) {
        if (self.selected_seat_limit) {
            [self checkSeatLimitWithSeat:sender];
        } else {
            [self setSeatAsSelected:sender];
            [selected_seats addObject:sender];
        }
    } else {
        [selected_seats removeObject:sender];
        if (sender.available && sender.disabled) {
            [self setSeatAsDisabled:sender];
        } else if (sender.available && !sender.disabled) {
            //[self setSeatAsAvaiable:sender];
            
            if(sender.row == 1 && sender.column == 3){
                [self setLadiesSeatAsAvaiable:sender];
            }
           else if (sender.row == 2 && sender.column == 3) {
                [self setLadiesSeatAsAvaiable:sender];
            }
           else if (sender.row == 4 && sender.column == 4) {
               [self setLadiesSeatAsAvaiable:sender];
           }
           else if (sender.row == 5 && sender.column == 4) {
               [self setLadiesSeatAsAvaiable:sender];
           }
           else{
               [self setSeatAsAvaiable:sender];
           }
        }
    }
    
    [self.seat_delegate seatSelected:sender];
    [self.seat_delegate getSelectedSeats:selected_seats];
}
- (void)checkSeatLimitWithSeat:(ZSeat*)sender{
    if ([selected_seats count]<self.selected_seat_limit) {
        [self setSeatAsSelected:sender];
        [selected_seats addObject:sender];
    } else {
        ZSeat *seat_to_make_avaiable = [selected_seats objectAtIndex:0];
        if (seat_to_make_avaiable.disabled)
            [self setSeatAsDisabled:seat_to_make_avaiable];
        else
            [self setSeatAsAvaiable:seat_to_make_avaiable];
        [selected_seats removeObjectAtIndex:0];
        [self setSeatAsSelected:sender];
        [selected_seats addObject:sender];
    }
}

#pragma mark - Seat Images & Availability

- (void)setAvailableImage:(UIImage *)available_image andUnavailableImage:(UIImage *)unavailable_image andDisabledImage:(UIImage *)disabled_image andSelectedImage:(UIImage *)selected_image andSteeringImage:(UIImage*)steering_image andladiesseatImage:(UIImage*)ladiesseat_image{
    
    self.available_image    = available_image;
    self.unavailable_image  = unavailable_image;
    self.disabled_image     = disabled_image;
    self.selected_image     = selected_image;
    self.steering_image     = steering_image;
    self.ladiesseat_image = ladiesseat_image;
    
}
- (void)setSeatAsUnavaiable:(ZSeat*)sender{
    [sender setImage:self.unavailable_image forState:UIControlStateNormal];
    [sender setSelected_seat:TRUE];
}

- (void)setSteering:(ZSeat*)sender{
    [sender setImage:self.steering_image forState:UIControlStateNormal];
    //[sender setSelected_seat:TRUE];
}

- (void)setSeatAsAvaiable:(ZSeat*)sender{
    [sender setImage:self.available_image forState:UIControlStateNormal];
    [sender setSelected_seat:FALSE];
}

- (void)setLadiesSeatAsAvaiable:(ZSeat*)sender{
    [sender setImage:self.ladiesseat_image forState:UIControlStateNormal];
    [sender setSelected_seat:FALSE];
}

- (void)setSeatAsDisabled:(ZSeat*)sender{
    [sender setImage:self.disabled_image forState:UIControlStateNormal];
    [sender setSelected_seat:FALSE];
}
- (void)setSeatAsSelected:(ZSeat*)sender{
    [sender setImage:self.selected_image forState:UIControlStateNormal];
    [sender setSelected_seat:TRUE];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    // NSLog(@"didZoom");
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [self.subviews objectAtIndex:0];
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    //NSLog(@"scrollViewWillBeginZooming");
}

@end
