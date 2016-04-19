//
//  ViewController.m
//  Device Motion Demo
//
//  Created by Sebastián Badea on 18/4/16.
//  Copyright © 2016 Sebastian Badea. All rights reserved.
//

@import CoreMotion;
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) CMMotionManager *coreMotionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = [UIImage imageNamed:@"dog.jpg"];
    
    self.coreMotionManager = [[CMMotionManager alloc] init];
    [self.coreMotionManager startDeviceMotionUpdates];
    
    self.coreMotionManager.accelerometerUpdateInterval = 0.01; //seconds
    
    ViewController * __weak weakSelf = self;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [self.coreMotionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        /* do work here */
        double x = deviceMotion.gravity.x;
        double y = deviceMotion.gravity.y;
        
        double rotation = -atan2(x, y);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            /* Update UI here */
            weakSelf.imageView.transform = CGAffineTransformMakeRotation(rotation);
        }];
    }];
}

@end
