//
//  HLSwipeViewController.m
//  NoteMore
//
//  Created by tusm on 16/8/19.
//  Copyright © 2016年 com.herylong. All rights reserved.
//

#import "HLSlideViewController.h"

@interface HLSlideViewController ()

@property (nonatomic, assign) NSInteger slide2x;

@end

@implementation HLSlideViewController

-(id) initWithLeftViewController:(UIViewController *)leftController
          andRightViewController:(UIViewController *)rightController {
    self = [super init];
    if(!self) return nil;

    self.leftViewController = leftController;
    self.rightViewController = rightController;
    self.slide2x = 200;
    
    return self;
}

-(id) initWithLeftViewController:(UIViewController *)leftViewController
          andRightViewController:(UIViewController *)rightViewController
                        bySlideX:(NSInteger)slidex {
    self = [self initWithLeftViewController:leftViewController andRightViewController:rightViewController];
    if(!self) return nil;
    
    self.slide2x = slidex;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // add the event chain
    [self addChildViewController:self.leftViewController];
    [self addChildViewController:self.rightViewController];
    // add the view hiearcy
    [self.view addSubview:self.leftViewController.view];
    [self.view addSubview:self.rightViewController.view];
    
    // use UIPanGestureRecognizer to process the slide effect.
    UIPanGestureRecognizer *panGestureRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanEvent:)];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.minimumNumberOfTouches = 1;
    [self.rightViewController.view addGestureRecognizer:panGestureRecognizer];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = TRUE;
    // if the statusBar or navigationBar existed
    int topBarHight = 0;
    if(!UIApplication.sharedApplication.isStatusBarHidden) {
        topBarHight += UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    if(!self.navigationController.isNavigationBarHidden) {
        topBarHight += self.navigationController.navigationBar.frame.size.height;
    }
    // rightViewController's default y' location
    _beginPoint.y = topBarHight;
    
    self.leftViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[
                                // self.leftViewController Constraints
                                [NSLayoutConstraint constraintWithItem:self.leftViewController.view
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:topBarHight],
                                [NSLayoutConstraint constraintWithItem:self.leftViewController.view
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.leftViewController.view
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.leftViewController.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0.0],
                                // self.rightViewController Constraints
                                [NSLayoutConstraint constraintWithItem:self.rightViewController.view
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:topBarHight],
                                [NSLayoutConstraint constraintWithItem:self.rightViewController.view
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.rightViewController.view
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0],
                                [NSLayoutConstraint constraintWithItem:self.rightViewController.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0.0]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Slide ViewController
CGPoint _beginPoint;
CGSize _beginSize;
-(void) handlePanEvent:(UIPanGestureRecognizer*) sender {
    CGPoint touch = [sender translationInView:self.view];
    CGRect current = self.rightViewController.view.frame;
    
    float dest_x = 0.0;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _beginPoint = current.origin;
            _beginSize = current.size;
            dest_x = _beginPoint.x;
            break;
        case UIGestureRecognizerStateChanged:
            // set the single direction to the left;
            dest_x = _beginPoint.x + touch.x >= 0 ? _beginPoint.x + touch.x : 0;
            break;
        case UIGestureRecognizerStateEnded:
            if(current.origin.x <= UIScreen.mainScreen.bounds.size.width/2) {
                dest_x = 0;
            }
            if(current.origin.x > UIScreen.mainScreen.bounds.size.width/2) {
                dest_x = self.slide2x;
            }
            break;
        default:
            break;
    }
    // set the view location
    [self slideLeftViewController2fix:dest_x];
}

-(BOOL) slideLeftViewController2origin {
    [self slideLeftViewController2fix:0.0];
    return TRUE;
}

-(BOOL) slideLeftViewController2slidex {
    [self slideLeftViewController2fix:self.slide2x];
    return TRUE;
}

-(BOOL) slideLeftViewController2fix:(CGFloat) x {
    [self.rightViewController.view
        setFrame:CGRectMake(x, _beginPoint.y, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    return TRUE;
}

#pragma mark - Message Forwarding
-(id) forwardingTargetForSelector:(SEL)aSelector {
    // the leftViewController and rightViewController cound communicate with self
    if([self.leftViewController respondsToSelector:aSelector]) {
        return self.leftViewController;
    }
    if([self.rightViewController respondsToSelector:aSelector]) {
        return self.rightViewController;
    }
    return self.parentViewController;
}

@end
