//
//  ViewController.m
//  ZSeatSelector
//
//  Created by Ricardo Zertuche on 7/30/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize seatslist1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *map = @"AAAAA_DAAAA/"
//                    @"UAAAA_DAAAA/"
//                    @"UUUUU_DAAAA/"
//                    @"UAAAA_AAAAA/"
//                    @"AAAAA_AAAAA/";
    
    
   
    
    
    NSString * jsonString = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"json"];

    NSString *myFile = [[NSString alloc]initWithContentsOfFile:jsonString encoding:NSUTF8StringEncoding error:nil];

    NSError *error =  nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myFile dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];

    NSLog(@"--- %@",json);
    
    NSLog(@"no of allseatsinfo %@",[[json objectForKey:@"item"] objectForKey:@"allseatsinfo"]);

    
    int noOfColumns = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"columns"] intValue];
    NSLog(@"noOfColumns: %d", noOfColumns);
    
    int dividerrow = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"dividerrow"] intValue];
    NSLog(@"dividerrow: %d", dividerrow);
    
    int rows = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"rows"] intValue];
    NSLog(@"rows: %d", rows);
    
    int waitinglistseats = [(NSNumber *)[[json objectForKey:@"item"] objectForKey:@"waitinglistseats"] intValue];
    NSLog(@"waitinglistseats: %d", waitinglistseats);
    
    NSString *allseatsinfo = [[json objectForKey:@"item"] objectForKey:@"allseatsinfo"];
      NSLog(@"allseatsinfo: %@", allseatsinfo);
    
    
    seatslist1 = [[NSMutableArray alloc]init];
    
    seatslist1 = [[allseatsinfo componentsSeparatedByString:@"|"] mutableCopy];
      NSLog(@"seatslist1: %@", seatslist1);
    
      // NSArray *seatslist2 = [allseatsinfo componentsSeparatedByString:@"||"];
      //NSLog(@"seatslist2: %@", seatslist2);
    
    NSString *map = @"E";
    
    if(seatslist1.count>0){
        
        
        for (int i=0;i<(noOfColumns * rows);i++){
            if(i>0 && i%noOfColumns == 0){
                
            }
            if(i==0 || i%noOfColumns ==0){
                
            }
        }
    }
    NSMutableArray *seatsCheckList;
      for(int i=0;i<(noOfColumns * rows);i++){
          
              seatsCheckList = [[[seatslist1 objectAtIndex:i] componentsSeparatedByString:@","] mutableCopy];
          
          if([[seatsCheckList objectAtIndex:0] isEqualToString:@""]){
              
             // map = [map stringByAppendingString:@"_"];
              
          }
         else  if([[seatsCheckList objectAtIndex:2] intValue] == i)
          {
          }
           else if ([[seatsCheckList objectAtIndex:2] intValue] != i){
               
              
               
               [seatslist1 insertObject:@"_" atIndex:i];
                NSLog(@"seatslist1 %@",seatslist1);
           }
          
      }
    
    
    NSLog(@"seatsCheckList %@",seatsCheckList);
    
    
    /**/
    
    for(int i=0;i<[seatslist1 count];i++){
        
         if(i<[seatslist1 count]){
             
            
         NSArray *seatsCheckList = [[seatslist1 objectAtIndex:i] componentsSeparatedByString:@","];
        

        NSLog(@"seatsCheckList %@",seatsCheckList);
        
        //if()
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
        }
        else {
            
        
             NSLog(@"i value is --------- %d",i);
            
         
                 map = [map stringByAppendingString:@"_"];
        
        }
         }
//        else{
//            map = [map stringByAppendingString:@"_"];
//        }
        
    
      
       // NSLog(@"list is %@",[seatsCheckList objectAtIndex:i]);
    }
    
    
    NSLog(@"map %@",map);
    
   UIView *bookingSeatsView=[[UIView alloc]initWithFrame:CGRectMake(15, 30, self.view.frame.size.width-30, 180)];
   // [bookingSeatsView setBackgroundColor:[UIColor yellowColor]];
    bookingSeatsView.layer.borderColor = [UIColor grayColor].CGColor;
    bookingSeatsView.layer.borderWidth = 3.0f;
    [self.view addSubview:bookingSeatsView];
    
    
//    NSString *map = @"EALAAA_UAAAA/"
//    @"_ULAAA_UAAAAAAAAAAAAAAA/"
//    @"___________A/"
//    @"_UALAAAAAAAA/"
//    @"_AALAAAAAAAA/";

    
    //[NSString stringWithFormat:@"%@/%@/%@", one, two, three];
    /**/

    
    NSLog(@" map %@", map);

    ZSeatSelector *seat = [[ZSeatSelector alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-30, 180)];
//bookingSeatsView
    
//    ZSeatSelector *seat = [[ZSeatSelector alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 160)];
    
    //seat.tag =
   // [seat setSeatSize:CGSizeMake(32, 32)];
    
     [seat setSeatSize:CGSizeMake(30, 30)]; // iphone6s
    
    // [seat setSeatSize:CGSizeMake(23, 23)]; // iphone5s
    
    
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
    [seat setMap:map];
    
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

- (void)seatSelected:(ZSeat *)seat{
    
//    if([seat count]==3){
//        return;
//    }
    
    //NSLog(@"seatslist1 id %@",seat.selected_seat);
    
    
     UIButton *button = (UIButton *)seat;
    //NSInteger i = [sender tag];
    
    
    
    NSLog(@"selected seat ID is %@", [seatslist1 objectAtIndex:button.tag]);
    
     NSArray *seatsCheckList = [[seatslist1 objectAtIndex:button.tag] componentsSeparatedByString:@","];
    
    NSLog(@"selected seat ID is %@", [seatsCheckList objectAtIndex:0]);
    
    NSLog(@"Seat at Row:%ld and Column:%ld", (long)seat.row,(long)seat.column);
}

-(void)getSelectedSeats:(NSMutableArray *)seats{
    
    
    
    float total=0;
    for (int i=0; i<[seats count]; i++) {
        ZSeat *seat = [seats objectAtIndex:i];
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
