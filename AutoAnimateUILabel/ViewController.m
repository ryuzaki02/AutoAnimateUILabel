//
//  ViewController.m
//  AutoAnimateUILabel
//
//  Created by Rajvinder Singh on 12/10/16.
//  Copyright © 2016 Ryuzaki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UILabel *myLabel;
    __weak IBOutlet NSLayoutConstraint *myLabelLeadingConstraint;
    
    CGFloat intialPoint;
    NSTimer *myTimer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [myLabelLeadingConstraint setConstant:[UIScreen mainScreen].bounds.size.width];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action
- (IBAction)startButtonAction:(id)sender
{
    [self setTimer];
}

#pragma mark - Temp Work
-(void) tempAnimation
{
    [myLabelLeadingConstraint setConstant:myLabelLeadingConstraint.constant-5];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (myLabelLeadingConstraint.constant == -myLabel.frame.size.width)
        {
            [myTimer invalidate];
            [myLabelLeadingConstraint setConstant:[UIScreen mainScreen].bounds.size.width];
            [self setTimer];
        }
    }];
}

-(void) setTimer
{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tempAnimation) userInfo:nil repeats:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *touchArr = [touches allObjects];
    UITouch *touch = [touchArr firstObject];
    CGPoint point = [touch locationInView:self.view];
    if (point.y > myLabel.frame.origin.y && point.y < myLabel.frame.origin.y + myLabel.frame.size.height)
    {
        [myTimer invalidate];
        intialPoint = point.x;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!myTimer.isValid)
    {
        [self setTimer];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *touchArr = [touches allObjects];
    UITouch *touch = [touchArr firstObject];
    CGPoint point = [touch locationInView:self.view];
    if (point.y > myLabel.frame.origin.y && point.y < myLabel.frame.origin.y + myLabel.frame.size.height)
    {
        if (point.x-intialPoint > 10)
        {
            [myLabelLeadingConstraint setConstant:(myLabelLeadingConstraint.constant+5)];
        }
        else if (point.x-intialPoint < -10)
        {
            [myLabelLeadingConstraint setConstant:(myLabelLeadingConstraint.constant-5)];
        }
    }
    
}

@end
