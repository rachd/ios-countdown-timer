//
//  ViewController.m
//  CountdownTimer
//
//  Created by Rachel Dorn on 9/10/16.
//  Copyright © 2016 RachelDorn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIDatePicker *timer;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timer = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 260)];
    self.timer.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.view addSubview:self.timer];
    
    [self setUpStartButton];
    
}

- (void)setUpStartButton {
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake(20, self.view.frame.size.height - 120, self.view.frame.size.width - 40, 40);
    [self.startButton setTitle:@"Start Timer" forState:UIControlStateNormal];
    [self.startButton addTarget:self
                         action:@selector(startOneOffTimer:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
}

- (void)startOneOffTimer:sender {
    
    [NSTimer scheduledTimerWithTimeInterval:self.timer.countDownDuration
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil//[self userInfo]
                                    repeats:NO];
}

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
}

- (void)targetMethod:(NSTimer *)theTimer {
//    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
//    NSLog(@"Timer finished at %@", startDate);
    
    UIAlertController *timerAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"The timer has finished" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    [timerAlert addAction:defaultAction];
    [self presentViewController:timerAlert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
