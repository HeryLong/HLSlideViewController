//
//  HLSwipeViewController.h
//  NoteMore
//
//  Created by tusm on 16/8/19.
//  Copyright © 2016年 com.herylong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLSlideViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;

-(id) initWithLeftViewController:(UIViewController*) leftViewController
          andRightViewController:(UIViewController*) rightViewController;

-(id) initWithLeftViewController:(UIViewController *)leftViewController
          andRightViewController:(UIViewController *)rightViewController
                        bySlideX:(NSInteger) slidex;

-(BOOL) slideLeftViewController2origin;
-(BOOL) slideLeftViewController2slidex;
-(BOOL) slideLeftViewController2fix:(CGFloat) x;

@end
