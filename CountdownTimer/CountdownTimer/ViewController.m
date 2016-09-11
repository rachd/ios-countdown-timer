//
//  ViewController.m
//  CountdownTimer
//
//  Created by Rachel Dorn on 9/10/16.
//  Copyright © 2016 RachelDorn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIDatePicker *timerPicker;
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
    
    self.timerRunning = NO;
    
    [self setUpTimerPicker];
    [self setUpStartButton];
    [self setUpCountDownLabel];
    
}

- (void)setUpTimerPicker {
    self.timerPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 260)];
    self.timerPicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.view addSubview:self.timerPicker];
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
    self.countdownLabel.textAlignment = NSTextAlignmentCenter;
    self.countdownLabel.font = [UIFont systemFontOfSize:30];
    self.countdownLabel.text = [self formatTimeFromSeconds:0];
    [self.view addSubview:self.countdownLabel];
}

- (void)buttonTapped {
    if (self.timerRunning) {
        [self stopTimers];
    } else {
        [self startTimers];
    }
}

- (void)startTimers {
    self.timerRunning = YES;
    self.startButton.selected = YES;
    self.secondsRemaining = self.timerPicker.countDownDuration;
    self.countdownLabel.text = [self formatTimeFromSeconds:self.secondsRemaining];
    
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
    self.countdownLabel.text = [self formatTimeFromSeconds:self.secondsRemaining];
}

- (void)stopTimers {
    [self.secondsTimer invalidate];
    [self.mainTimer invalidate];
    self.countdownLabel.text = [self formatTimeFromSeconds:0];
    self.timerRunning = NO;
    self.startButton.selected = NO;
}

- (void)finishMainTimer:(NSTimer *)theTimer {
    
    [self stopTimers];
    
    UIAlertController *timerAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"The timer has finished" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    [timerAlert addAction:defaultAction];
    [self presentViewController:timerAlert animated:YES completion:nil];
}

- (NSString *)formatTimeFromSeconds:(int)totalSeconds {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
