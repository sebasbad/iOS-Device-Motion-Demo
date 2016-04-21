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

@property (strong, nonatomic) NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = [UIImage imageNamed:@"dog.jpg"];
    self.images = @[[UIImage imageNamed:@"dog.jpg"], [UIImage imageNamed:@"lemur_selfie.jpg"], [UIImage imageNamed:@"monkey_smile.jpg"], [UIImage imageNamed:@"tiny_pig.jpg"]];
    
    [self chooseImage:0.0];
    
    self.coreMotionManager = [[CMMotionManager alloc] init];
    [self.coreMotionManager startDeviceMotionUpdates];
    
    self.coreMotionManager.accelerometerUpdateInterval = 0.01; //seconds
    
    ViewController * __weak weakSelf = self;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [self.coreMotionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        /* do work here */
        double x = deviceMotion.gravity.x;
        double y = deviceMotion.gravity.y;
        
        double rotation = -atan2(x, -y);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            /* Update UI here */
            weakSelf.imageView.transform = CGAffineTransformMakeRotation(rotation);
        }];
    }];
}

- (void)chooseImage:(double)yaw {
    // yaw in radians
    NSLog(@"%f %f", yaw, M_PI_4);
    
    if (M_PI_4 >= yaw) {
        if (-M_PI_4 <= yaw) {
            // between -45 and 45 degrees
            self.imageView.image = self.images[0];
        } else if (-3.0 * M_PI_4 <= yaw) {
            // between -45 and -135 degrees
            self.imageView.image = self.images[1];
        } else {
            // between -135 and -225 degrees
            self.imageView.image = self.images[2];
        }
    } else {
        if (3.0 * M_PI_4 >= yaw) {
            // between 135 and 225 degrees
            self.imageView.image = self.images[3];
        } else {
            // between 225 and 315 degrees
            self.imageView.image = self.images[2];
        }
    }
}

@end
