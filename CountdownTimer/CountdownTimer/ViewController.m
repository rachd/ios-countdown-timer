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
@property (nonatomic, strong) NSTimer *mainTimer;
@property (nonatomic) NSTimeInterval secondsRemaining;
@property (nonatomic) BOOL timerRunning;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timer = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 260)];
    self.timer.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.view addSubview:self.timer];
    
    self.timerRunning = NO;
    
    [self setUpStartButton];
    [self setUpCountDownLabel];
    
}

- (void)setUpStartButton {
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake(20, self.view.frame.size.height - 120, self.view.frame.size.width - 40, 40);
    [self.startButton setTitle:@"Start Timer" forState:UIControlStateNormal];
    [self.startButton setTitle:@"Stop Timer" forState:UIControlStateSelected];
    [self.startButton addTarget:self
                         action:@selector(buttonTapped)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
}

- (void)setUpCountDownLabel {
    self.countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 200, self.view.frame.size.width - 40, 40)];
    [self.view addSubview:self.countdownLabel];
}

- (void)buttonTapped {
    if (self.timerRunning) {
        [self stopTimers];
        self.startButton.selected = NO;
    } else {
        [self startTimers];
        self.startButton.selected = YES;
    }
}

- (void)startTimers {
    self.timerRunning = YES;
    
    self.secondsRemaining = self.timer.countDownDuration;
    
    self.countdownLabel.text = [NSString stringWithFormat:@"seconds remaining; %f", self.secondsRemaining];
    
    self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:self.secondsRemaining
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

- (void)stopTimers {
    [self.secondsTimer invalidate];
    [self.mainTimer invalidate];
    self.timerRunning = NO;
}

- (void)finishMainTimer:(NSTimer *)theTimer {
    
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
