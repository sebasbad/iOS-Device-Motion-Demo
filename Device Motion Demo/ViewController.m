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
    
    CMAttitudeReferenceFrame frame = CMAttitudeReferenceFrameXArbitraryZVertical;
    
    [self.coreMotionManager startDeviceMotionUpdatesUsingReferenceFrame:frame toQueue:queue withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        /* do work here */
        double yaw = deviceMotion.attitude.yaw;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            /* Update UI here */
            weakSelf.imageView.transform = CGAffineTransformMakeRotation(yaw);
            [self chooseImage:yaw];
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
