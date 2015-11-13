//
//  ViewController.m
//  BattleToads
//
//  Created by Pasha on 14.11.15.
//  Copyright © 2015 gzvsky. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) UIImageView* testImageView;
@property (strong, nonatomic) AVAudioPlayer* player;
@property (assign, nonatomic) BOOL blinkFaceForward;
@property (assign, nonatomic) BOOL blinkFaceBakward;
@property (assign, nonatomic) BOOL isMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blinkFaceForward = YES;
    self.blinkFaceBakward = NO;
    self.isMoving = NO;
    
    UIImageView* imageWithFrame = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1.07*CGRectGetWidth(self.view.bounds), 1.07*CGRectGetHeight(self.view.bounds))];
    imageWithFrame.image = [UIImage imageNamed:@"levelBackground.png"];
    [self.view addSubview:imageWithFrame];
    
    UIImageView* myView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)/2, 60, 60 * 50/37)];
    myView.backgroundColor = [UIColor clearColor];
    
    UIImage* image1 = [UIImage imageNamed:@"one.png"];
    myView.image = image1;
    
    [self.view addSubview:myView];
    
    self.testImageView = myView;
    
    [self playBackgroundMusic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self blinckingAnimationForward:self.testImageView];
}

- (void) blinckingAnimationForward:(UIImageView*) imageView {
    
    self.blinkFaceBakward = NO;
    
    if (self.blinkFaceForward && !self.isMoving) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.blinkFaceForward && !self.isMoving) {
                
                UIImage* image1 = [UIImage imageNamed:@"one.png"];
                UIImage* image2 = [UIImage imageNamed:@"blinkingEyes.png"];
                
                NSArray* standStillAnimation = [[NSArray alloc] initWithObjects:image1, image2, image1, nil];
                imageView.animationImages = standStillAnimation;
                imageView.animationDuration = 0.5f;
                
                [imageView startAnimating];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.blinkFaceForward && !self.isMoving) {
                    [imageView stopAnimating];
                    
                    __weak UIImageView* weakImageView = imageView;
                    [self blinckingAnimationForward:weakImageView];
                }
            });
        });
    }
}

- (void) blinckingAnimationBakward:(UIImageView*) imageView {
    
    self.blinkFaceForward = NO;
    
    if (self.blinkFaceBakward && !self.isMoving) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.blinkFaceBakward && !self.isMoving) {
                
                UIImage* image1 = [UIImage imageNamed:@"oneMirror.png"];
                UIImage* image2 = [UIImage imageNamed:@"blinkingEyesMirror.png"];
                
                NSArray* standStillAnimation = [[NSArray alloc] initWithObjects:image1, image2, image1, nil];
                imageView.animationImages = standStillAnimation;
                imageView.animationDuration = 0.5f;
                
                [imageView startAnimating];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.blinkFaceBakward && !self.isMoving) {
                    [imageView stopAnimating];
                    
                    __weak UIImageView* weakImageView = imageView;
                    [self blinckingAnimationBakward:weakImageView];
                }
            });
        });
    }
}

- (void) moveForward:(UIImageView*) imageView withDuration:(CGFloat) duration toPoint:(CGPoint) point{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.blinkFaceForward = NO;
                         self.isMoving = YES;
                         
                         UIImage* image2 = [UIImage imageNamed:@"two.png"];
                         UIImage* image3 = [UIImage imageNamed:@"three.png"];
                         UIImage* image4 = [UIImage imageNamed:@"four.png"];
                         UIImage* image5 = [UIImage imageNamed:@"five.png"];
                         UIImage* image6 = [UIImage imageNamed:@"six.png"];
                         
                         NSArray* runAnimationForfward = [[NSArray alloc] initWithObjects:image3, image6, image5, image2, image4, image5, nil];
                         imageView.animationImages = runAnimationForfward;
                         imageView.animationDuration = 0.7f;
                         
                         [imageView startAnimating];
                         self.view.userInteractionEnabled = false;
                         
                         imageView.center = CGPointMake(point.x, point.y - CGRectGetHeight(imageView.frame)/4);
                     }
                     completion:^(BOOL finished) {
                         
                         [imageView stopAnimating];
                         UIImage* image1 = [UIImage imageNamed:@"one.png"];
                         imageView.image = image1;
                         
                         self.view.userInteractionEnabled = true;
                         self.blinkFaceForward = YES;
                         self.isMoving = NO;
                         
                         __weak UIImageView* weakImageView = imageView;
                         [self blinckingAnimationForward:weakImageView];
                     }];
}

- (void) moveBackward:(UIImageView*) imageView withDuration:(CGFloat) duration toPoint:(CGPoint) point{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.blinkFaceBakward = NO;
                         self.isMoving = YES;
                         
                         UIImage* image2 = [UIImage imageNamed:@"twoMirror.png"];
                         UIImage* image3 = [UIImage imageNamed:@"threeMirror.png"];
                         UIImage* image4 = [UIImage imageNamed:@"fourMirror.png"];
                         UIImage* image5 = [UIImage imageNamed:@"fiveMirror.png"];
                         UIImage* image6 = [UIImage imageNamed:@"sixMirror.png"];
                         
                         NSArray* runAnimationForfward = [[NSArray alloc] initWithObjects:image3, image6, image5, image2, image4, image5, nil];
                         imageView.animationImages = runAnimationForfward;
                         imageView.animationDuration = 0.7f;
                         
                         [imageView startAnimating];
                         self.view.userInteractionEnabled = false;
                         
                         imageView.center = CGPointMake(point.x, point.y - CGRectGetHeight(imageView.frame)/4);
                     }
                     completion:^(BOOL finished) {
                         
                         [imageView stopAnimating];
                         UIImage* image1 = [UIImage imageNamed:@"oneMirror.png"];
                         imageView.image = image1;
                         
                         self.view.userInteractionEnabled = true;
                         self.blinkFaceBakward = YES;
                         self.isMoving = NO;
                         
                         __weak UIImageView* weakImageView = imageView;
                         [self blinckingAnimationBakward:weakImageView];
                     }];
}

- (CGFloat) durationTimeFromDistance:(CGFloat) distance {
    
    CGFloat speed = 4940 / 27;
    CGFloat time = distance / speed;
    return time;
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
    CGPoint touchPoint = [sender locationInView:self.view];
    CGRect myViewRect = [self.testImageView.layer.presentationLayer frame];
    
    CGFloat distanceX = fabs(myViewRect.origin.x + myViewRect.size.width/2 - touchPoint.x);
    CGFloat distanceY = 1.3 * fabs(myViewRect.origin.y + myViewRect.size.height - myViewRect.size.height/4 - touchPoint.y);
    
    CGFloat fullDistance = sqrt(distanceX*distanceX + distanceY*distanceY);
    
    CGFloat duration = [self durationTimeFromDistance:fullDistance];
    
    if ((myViewRect.origin.x + myViewRect.size.width/2) < touchPoint.x) {
        [self moveForward:self.testImageView withDuration:duration toPoint:touchPoint];
    } else {
        [self moveBackward:self.testImageView withDuration:duration toPoint:touchPoint];
    }
}

- (void) playBackgroundMusic {
    
    NSString* soundPath = [[NSBundle mainBundle] pathForResource:@"level1.mp3" ofType:nil];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:soundPath] error:nil];
    [self.player play];
}

@end
