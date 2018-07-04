//
//  ViewController.m
//  BusSeatsBookingManagement
//
//  Created by admin on 04/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize seatsList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString * jsonString = [[NSBundle mainBundle] pathForResource:@"sleeper" ofType:@"json"];
    
    NSString *myFile = [[NSString alloc]initWithContentsOfFile:jsonString encoding:NSUTF8StringEncoding error:nil];
    
    NSError *error =  nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myFile dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSLog(@"--- %@",json);
    
    int noOfColumns = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"columns"] intValue];
    
    
        delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
     delegate.noOfColumnsAppDel = noOfColumns;
    
    
  //  int dividerrow = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"dividerrow"] intValue];
    int rows = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"rows"] intValue];
   // int waitinglistseats = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"waitinglistseats"] intValue];
    rows = 7;
    
    int numberoflevels = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"numberoflevels"] intValue];
    
    NSLog(@"numberoflevels %d", numberoflevels);
    delegate.noOfLevelsAppDel = numberoflevels;
    
    NSString *allseatsinfo = [[json objectForKey:@"item"] objectForKey:@"allseatsinfo"];

    seatsList = [[NSMutableArray alloc]init];
    
    seatsList = [[allseatsinfo componentsSeparatedByString:@"|"] mutableCopy];
    NSLog(@"seatslist initial: %@", seatsList);
    
   
    
    NSString *map = @"E";
    
  
    NSMutableArray *seatsCheckList;
    
    if(seatsList.count>0){
        if(numberoflevels ==2 ){
            int totalrecursive = noOfColumns * rows +noOfColumns;
            
   // for(int i=0;i<(noOfColumns * rows);i++){
     
             for(int i=0;i<totalrecursive;i++){
                 
        seatsCheckList = [[[seatsList objectAtIndex:i] componentsSeparatedByString:@","] mutableCopy];
               
        if([[seatsCheckList objectAtIndex:0] isEqualToString:@""]){
            
        }
        else  if([[seatsCheckList objectAtIndex:2] intValue] == i)
        {
        }
        else if ([[seatsCheckList objectAtIndex:2] intValue] != i){
        
            [seatsList insertObject:@"_" atIndex:i];
        }
        }
    }
        
      //  delegate.seatsListAppDel = [seatsList mutableCopy];
        
       // NSLog(@"delegate.seatsListAppDel initial: %@", delegate.seatsListAppDel);
     }
    
    int nb = (int)seatsList.count/2;
    
    NSLog(@"nb value is %d", nb);

//    if(nb==24){
//        for(int x=nb;x<nb+noOfColumns;x++){
//
//             [seatsList insertObject:@"_" atIndex:x+1];
//        }
//    }
  
    [delegate.seatsListAppDel removeAllObjects];
    
    delegate.seatsListAppDel = [seatsList mutableCopy];
     NSLog(@"delegate.seatsListAppDel initial: %@", delegate.seatsListAppDel);
    
    
    
    
    
    
    
    NSLog(@"seatslist with spaces: %@", seatsList);
    
    NSLog(@"seatsCheckList %@",seatsCheckList);
    
    for(int i=0;i<[seatsList count];i++){
        
        if(i==24){
            NSLog(@"i value is 24------");
        }
        
        if(i<[seatsList count]){
            
            NSArray *seatsCheckList = [[seatsList objectAtIndex:i] componentsSeparatedByString:@","];
    
            if(i>0 && i%noOfColumns == 0){
                map = [map stringByAppendingString:@"/"];
            }
            if(i>0 && i%noOfColumns ==0){
                map = [map stringByAppendingString:@"_"];
            }
        
            if([[seatsCheckList objectAtIndex:0] isEqualToString:@""]){
                
                map = [map stringByAppendingString:@"_"];
                
            }
            else if([[seatsCheckList objectAtIndex:0] isEqualToString:@"_"]){
                
                map = [map stringByAppendingString:@"_"];
                
            }
            else if([[seatsCheckList objectAtIndex:2] intValue] == i)
            {
                if([[seatsCheckList objectAtIndex:1] isEqualToString:@"availSeat"]){
                    
                    map = [map stringByAppendingString:@"A"];
                    
                }
                else if([[seatsCheckList objectAtIndex:1] isEqualToString:@"bookedSeat"]){
                    map = [map stringByAppendingString:@"U"];
                }
                else if([[seatsCheckList objectAtIndex:1] isEqualToString:@"ladiesSeat"]){
                    map = [map stringByAppendingString:@"L"];
                }
            }
            else {
                
                map = [map stringByAppendingString:@"_"];
                
            }
        }
    }
    
    
    NSLog(@"map %@",map);
    
    //rotate:
     /// if vertifical option
   // UIView *bookingSeatsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 380)];
   // bookingSeatsView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    // if horizontal option
    UIView *bookingSeatsView=[[UIView alloc]initWithFrame:CGRectMake(15, 30, self.view.frame.size.width-30, 300)];
      bookingSeatsView.layer.borderColor = [UIColor grayColor].CGColor;
     bookingSeatsView.layer.borderWidth = 3.0f;
    
    
    // [bookingSeatsView setBackgroundColor:[UIColor yellowColor]];
    
    [self.view addSubview:bookingSeatsView];
    
    
    
    NSLog(@" map %@", map);
    
      /// if vertifical option
//    BSeatSelector *seat = [[BSeatSelector alloc]initWithFrame:CGRectMake(0, 0, 400, 380)];
//     seat.transform = CGAffineTransformMakeRotation(M_PI_2);
    
        // [bookingSeatsView setBackgroundColor:[UIColor blueColor]];
    
    // if horizontal option
    BSeatSelector *seat = [[BSeatSelector alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-30, 300)];
    
    //bookingSeatsView
    
    //rorate:
    
   
    
    //    ZSeatSelector *seat = [[ZSeatSelector alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 160)];
    
    //seat.tag =
    // [seat setSeatSize:CGSizeMake(32, 32)];
    
    //[seat setSeatSize:CGSizeMake(30, 30)]; // iphone6s
    
     [seat setSeatSize:CGSizeMake(40, 28)]; // iphone5s
    
    
    [seat setAvailableImage:[UIImage imageNamed:@"A"]
        andUnavailableImage:[UIImage imageNamed:@"U"]
           andDisabledImage:[UIImage imageNamed:@"D"]
           andSelectedImage:[UIImage imageNamed:@"S"]
           andSteeringImage:[UIImage imageNamed:@"E"] andladiesseatImage:[UIImage imageNamed:@"L"]];
    
    //    [seat setAvailableImage:[UIImage imageNamed:@"A"]
    //        andUnavailableImage:[UIImage imageNamed:@"U"]
    //           andDisabledImage:[UIImage imageNamed:@"D"]
    //           andSelectedImage:[UIImage imageNamed:@"S"]];
    [seat setSeat_price:30];
    [seat setSeatsAtPosition:map];
    
    [seat setSelected_seat_limit:3];
    
    seat.seat_delegate = self;
    // [self.view setBackgroundColor:[UIColor blueColor]];
    
    [bookingSeatsView addSubview:seat];
    //[self.view addSubview:seat];
    
    
    /*
     NSString *map2 =@"_DDDDDD_DDDDDD_DDDDDDDD_/"
     @"_AAAAAA_AAAAAA_DUUUAAAA_/"
     @"________________________/"
     @"_AAAAAUUAAAUAAAAUAAAAAAA/"
     @"_UAAUUUUUUUUUUUUUUUAAAAA/"
     @"_AAAAAAAAAAAUUUUUUUAAAAA/"
     @"_AAAAAAAAUAAAAUUUUAAAAAA/"
     @"_AAAAAUUUAUAUAUAUUUAAAAA/";
     
     ZSeatSelector *seat2 = [[ZSeatSelector alloc]initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 260)];
     
     [seat2 setSeatSize:CGSizeMake(24, 24)];
     [seat2 setAvailableImage:[UIImage imageNamed:@"A"]
     andUnavailableImage:[UIImage imageNamed:@"U"]
     andDisabledImage:[UIImage imageNamed:@"D"]
     andSelectedImage:[UIImage imageNamed:@"S"]];
     [seat2 setSeat_price:5.50];
     [seat2 setMap:map2];
     [seat2 setSelected_seat_limit:3];
     seat2.minimumZoomScale = 0.5;
     seat2.maximumZoomScale = 10.0;
     seat2.seat_delegate = self;
     
     [self.view addSubview:seat2];
     */
    
}

- (void)seatSelected:(BSeat *)seat{
    
    //    if([seat count]==3){
    //        return;
    //    }
    
    //NSLog(@"seatslist1 id %@",seat.selected_seat);
    
    UIButton *button = (UIButton *)seat;
    //NSInteger i = [sender tag];

    NSLog(@"selected seat ID is %@", [seatsList objectAtIndex:button.tag-1]);
    
    NSArray *seatsCheckList = [[seatsList objectAtIndex:button.tag-1] componentsSeparatedByString:@","];
    
    NSLog(@"selected seat ID is %@", [seatsCheckList objectAtIndex:0]);
    
    NSLog(@"Seat at Row:%ld and Column:%ld", (long)seat.row,(long)seat.column);
    
    
    
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if([delegate.selectedSeatsAppDel count]>0){
    NSLog(@"Total Seats Selected %@",delegate.selectedSeatsAppDel);
    }

}

-(void)getSelectedSeats:(NSMutableArray *)seats{
    
    float total=0;
    for (int i=0; i<[seats count]; i++) {
        BSeat *seat = [seats objectAtIndex:i];
        printf("Seat[%ld,%ld]\n",(long)seat.row,(long)seat.column);
        total += seat.price;
    }
    printf("--------- Total: %f\n",total);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
