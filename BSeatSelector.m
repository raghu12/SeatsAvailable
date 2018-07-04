//
//  BSeatSelector.m
//  BusSeatsBookingManagement
//
//  Created by admin on 04/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import "BSeatSelector.h"
#import "AppDelegate.h"

@implementation BSeatSelector

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Init and Configuration

- (void)setSeatSize:(CGSize)size{
seat_width = size.width;
seat_height = size.height;
}

- (void)setSeatsAtPosition:(NSString*)seatString{

self.delegate = self;
zoomable_view = [[UIView alloc]init];

int initial_seat_x = 0;
int initial_seat_y = 0;
int final_width = 0;

     int j=0;
    
    
  
    
for (int i = 0; i<seatString.length; i++) {
char seat_at_position = [seatString characterAtIndex:i];

    NSLog(@"j value is %d", j);
    
    if(j==35){
        
        NSLog(@"j Value is %d",j);
    }
    
if (seat_at_position == 'E') {
[self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:FALSE isDisabled:TRUE andConditionString:@"E" andTag:j];
    initial_seat_x += 1;
    j++;
    
}else if (seat_at_position == 'A') {
    [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:TRUE isDisabled:FALSE andConditionString:@"A" andTag:j];
initial_seat_x += 1;
        j++;

}else if (seat_at_position == 'L') {
[self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:TRUE isDisabled:FALSE andConditionString:@"L" andTag:j];
initial_seat_x += 1;
        j++;

} else if (seat_at_position == 'D') {
[self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:TRUE isDisabled:TRUE andConditionString:@"D" andTag:j];
    initial_seat_x += 1;
        j++;
    
} else if (seat_at_position == 'U') {
    [self createSeatButtonWithPosition:initial_seat_x and:initial_seat_y isAvailable:FALSE isDisabled:FALSE andConditionString:@"U" andTag:j];
    initial_seat_x += 1;
        j++;
    
}  else if(seat_at_position=='_'){
    initial_seat_x += 1;
  
   // j++;
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(i>0 && i%delegate.noOfColumnsAppDel == 0){
       // j--;

    } if(i==0 && i%delegate.noOfColumnsAppDel == 0){
       // j--;
        
    }else{
          j++; //correct
    }
   
    
    
} else {
    if (initial_seat_x>final_width) {
        final_width = initial_seat_x;
     
       // j++;
        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if(i>0 && i%delegate.noOfColumnsAppDel == 0){
            //j++;
            NSLog(@"last row j value is %d", j);
        }
       //  j--;
    }
   
    j--;
    initial_seat_x = 0;
    initial_seat_y += 1;
    
    
    
}
//        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if(i>0 && i%delegate.noOfColumnsAppDel == 0){
//        j--;
//
//    }
   
    
}
    
/*Scrolling*/
    zoomable_view.frame = CGRectMake(0, 15, final_width*seat_width, initial_seat_y*seat_height+140);
    
    
    
    /// if vertifical option
    // zoomable_view.frame = CGRectMake(0, 15, final_width*seat_width, initial_seat_y*seat_height);
   //  zoomable_view.frame = CGRectMake(0, 0, 400, 400);
    /*--*/
    // zoomable_view.backgroundColor = [UIColor blueColor];
    
    //zoomable_view.frame = CGRectMake(0, 15, self.frame.size.width, 210);
    
    //rorate:
    
    //zoomable_view.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [self setContentSize:zoomable_view.frame.size];
    
    /*Scrolling*/
    //CGFloat newContentOffsetX = (self.contentSize.width - self.frame.size.width) / 2;
    // self.contentOffset = CGPointMake(newContentOffsetX, 0);
    /*--*/
    
    /* self.contentOffset = CGPointMake(0,0); // starting position */
    
    selected_seats = [[NSMutableArray alloc]init];
    //[self setBackgroundColor:[UIColor blueColor]];
    [self addSubview:zoomable_view];
    
}

- (void)createSeatButtonWithPosition:(int)initial_seat_x and:(int)initial_seat_y isAvailable:(BOOL)available isDisabled:(BOOL)disabled{
    
    BSeat *seatButton = [[BSeat alloc]initWithFrame:
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

- (void)createSeatButtonWithPosition:(int)initial_seat_x and:(int)initial_seat_y isAvailable:(BOOL)available isDisabled:(BOOL)disabled andConditionString:(NSString*)conditionString andTag:(int)tagValue{
    
    BSeat *seatButton;
    
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    if(delegate.noOfLevelsAppDel == 2){
        
        int val1 =(int)delegate.seatsListAppDel.count/2;
        
        if ( tagValue == val1+1 ){
            UILabel *lab = [[UILabel alloc]initWithFrame:
                            CGRectMake(initial_seat_x*seat_width,
                                       initial_seat_y*seat_height,
                                       200,
                                       30)];
            lab.text = @"upper";
            lab.backgroundColor = [UIColor lightGrayColor];
            [zoomable_view addSubview:lab];
            
            seatButton = [[BSeat alloc]initWithFrame:
                          CGRectMake(initial_seat_x*seat_width,
                                     initial_seat_y*seat_height+40,
                                     seat_width,
                                     seat_height)];
        }
        else if(tagValue >= val1+1){
            seatButton = [[BSeat alloc]initWithFrame:
                          CGRectMake(initial_seat_x*seat_width,
                                     initial_seat_y*seat_height+40,
                                     seat_width,
                                     seat_height)];
        }
        else{
            seatButton = [[BSeat alloc]initWithFrame:
                          CGRectMake(initial_seat_x*seat_width,
                                     initial_seat_y*seat_height,
                                     seat_width,
                                     seat_height)];
        }
    }
    else{
        seatButton = [[BSeat alloc]initWithFrame:
                      CGRectMake(initial_seat_x*seat_width,
                                 initial_seat_y*seat_height,
                                 seat_width,
                                 seat_height)];
    }
    
    
    if (!available && disabled && [conditionString isEqualToString:@"E"]) {
        [self setSteering:seatButton];
        //return;
    } else if (available && disabled && [conditionString isEqualToString:@"D"]) {
        [self setSeatAsDisabled:seatButton];
    } else if (available && !disabled && [conditionString isEqualToString:@"A"]) {
        seatButton.tag = tagValue;
        [self setSeatAsAvaiable:seatButton];
    } else if (!available && !disabled && [conditionString isEqualToString:@"U"]) {
        seatButton.tag = tagValue;
        [self setSeatAsUnavaiable:seatButton];
    }else if (available && !disabled && [conditionString isEqualToString:@"L"]) {
        seatButton.tag = tagValue;
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

- (void)seatSelected:(BSeat*)sender{
    
    //    if([selected_seats count]==3){
    //        return;
    //    }
    
    if (!sender.selected_seat && sender.available) {
        if (self.selected_seat_limit) {
            [self checkSeatLimitWithSeat:sender];
        } else {
            [self setSeatAsSelected:sender];
            [selected_seats addObject:sender];
            
            /* add Object*/
            delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            NSArray *seatsCheckList = [[delegate.seatsListAppDel objectAtIndex:sender.tag-1] componentsSeparatedByString:@","];
            
            NSString *selectedIDValue = [NSString stringWithFormat:@"%@",[seatsCheckList objectAtIndex:0]];
            
            selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\\"
                                                                         withString:@""];
            
            selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\""
                                                 withString:@""];
            
            
            [delegate.selectedSeatsAppDel addObject:selectedIDValue];
          /*--*/
                
        }
    } else {
        [selected_seats removeObject:sender];
        
        /* remove Object*/
        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSArray *seatsCheckList = [[delegate.seatsListAppDel objectAtIndex:sender.tag-1] componentsSeparatedByString:@","];
        
        NSString *selectedIDValue = [NSString stringWithFormat:@"%@",[seatsCheckList objectAtIndex:0]];
        
        selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\\"
                                                                     withString:@""];
        
        selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\""
                                                                     withString:@""];
        
       // [delegate.selectedSeatsAppDel removeObject:[seatsCheckList objectAtIndex:0]];
         [delegate.selectedSeatsAppDel removeObject:selectedIDValue];
        /*--*/
        
        if (sender.available && sender.disabled) {
            [self setSeatAsDisabled:sender];
        } else if (sender.available && !sender.disabled) {
            [self setSeatAsAvaiable:sender];
        }
    }
    
    [self.seat_delegate seatSelected:sender];
    [self.seat_delegate getSelectedSeats:selected_seats];
}

- (void)checkSeatLimitWithSeat:(BSeat*)sender{
    if ([selected_seats count]<self.selected_seat_limit) {
        [self setSeatAsSelected:sender];
        [selected_seats addObject:sender];
        
        /* add Object*/
        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSArray *seatsCheckList = [[delegate.seatsListAppDel objectAtIndex:sender.tag-1] componentsSeparatedByString:@","];
        
        NSString *selectedIDValue = [NSString stringWithFormat:@"%@",[seatsCheckList objectAtIndex:0]];
        
        selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\\"
                                                                     withString:@""];
        
        selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\""
                                                                     withString:@""];
        
        
        [delegate.selectedSeatsAppDel addObject:selectedIDValue];
        /*--*/
        
    } else {
        BSeat *seat_to_make_avaiable = [selected_seats objectAtIndex:0];
        if (seat_to_make_avaiable.disabled)
            [self setSeatAsDisabled:seat_to_make_avaiable];
        else
            [self setSeatAsAvaiable:seat_to_make_avaiable];
        [selected_seats removeObjectAtIndex:0];
        
        /* remove Object*/
        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [delegate.selectedSeatsAppDel removeObjectAtIndex:0];
        /*--*/
        
        [self setSeatAsSelected:sender];
        [selected_seats addObject:sender];
        
        /* add Object*/
        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSArray *seatsCheckList = [[delegate.seatsListAppDel objectAtIndex:sender.tag-1] componentsSeparatedByString:@","];
        
        NSString *selectedIDValue = [NSString stringWithFormat:@"%@",[seatsCheckList objectAtIndex:0]];
        
        selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\\"
                                                                     withString:@""];
        
        selectedIDValue = [selectedIDValue stringByReplacingOccurrencesOfString:@"\""
                                                                     withString:@""];
        
        
        [delegate.selectedSeatsAppDel addObject:selectedIDValue];
        /*--*/
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

- (void)setSeatAsUnavaiable:(BSeat*)sender{
    [sender setImage:self.unavailable_image forState:UIControlStateNormal];
    [sender setSelected_seat:TRUE];
}

- (void)setSteering:(BSeat*)sender{
    [sender setImage:self.steering_image forState:UIControlStateNormal];
    //[sender setSelected_seat:TRUE];
}

- (void)setSeatAsAvaiable:(BSeat*)sender{
        [sender setImage:self.available_image forState:UIControlStateNormal];
        [sender setSelected_seat:FALSE];
}

- (void)setLadiesSeatAsAvaiable:(BSeat*)sender{
    [sender setImage:self.ladiesseat_image forState:UIControlStateNormal];
    [sender setSelected_seat:FALSE];
}

- (void)setSeatAsDisabled:(BSeat*)sender{
    [sender setImage:self.disabled_image forState:UIControlStateNormal];
    [sender setSelected_seat:FALSE];
}

- (void)setSeatAsSelected:(BSeat*)sender{
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
