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
@property (nonatomic, strong) UILabel *countdownLabel;
@property (nonatomic, strong) NSTimer *secondsTimer;
@property (nonatomic) NSTimeInterval secondsRemaining;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timer = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 260)];
    self.timer.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.view addSubview:self.timer];
    
    [self setUpStartButton];
    [self setUpCountDownLabel];
    
}

- (void)setUpStartButton {
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake(20, self.view.frame.size.height - 120, self.view.frame.size.width - 40, 40);
    [self.startButton setTitle:@"Start Timer" forState:UIControlStateNormal];
    [self.startButton addTarget:self
                         action:@selector(startTimer:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
}

- (void)setUpCountDownLabel {
    self.countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 160, self.view.frame.size.width - 40, 40)];
    self.countdownLabel.text = @"seconds remaining: ";
    [self.view addSubview:self.countdownLabel];
}

- (void)startTimer:sender {
    
    self.secondsRemaining = self.timer.countDownDuration;
    NSLog(@"seconds remaining: %f", self.secondsRemaining);
    
    [NSTimer scheduledTimerWithTimeInterval:self.secondsRemaining
                                     target:self
                                   selector:@selector(finishMainTimer:)
                                   userInfo:nil//[self userInfo]
                                    repeats:NO];
    
    
    
    self.secondsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateTimeLabel)
                                                    userInfo:nil
                                                     repeats:YES];
    
}

- (void)updateTimeLabel {
    self.secondsRemaining --;
    self.countdownLabel.text = [NSString stringWithFormat:@"seconds remaining: %f", self.secondsRemaining];
}

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
}

- (void)finishMainTimer:(NSTimer *)theTimer {
//    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
//    NSLog(@"Timer finished at %@", startDate);
    
    [self.secondsTimer invalidate];
    
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
