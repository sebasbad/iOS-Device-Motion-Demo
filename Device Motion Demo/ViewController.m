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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = [UIImage imageNamed:@"dog.jpg"];
}

@end
