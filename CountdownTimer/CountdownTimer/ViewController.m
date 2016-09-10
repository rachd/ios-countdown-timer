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
    [self.view addSubview:self.startButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
