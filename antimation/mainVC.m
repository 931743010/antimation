//
//  mainVC.m
//  antimation
//
//  Created by 邝泉 on 13-8-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "mainVC.h"
#import "QuartzCore/QuartzCore.h"

@interface mainVC()

-(void)animationOfUIKit;
-(void)animationOfBlock;
-(void)animationOfCABasicAnimation;
-(void)animationOfCAKeyframeAnimation;
-(void)animationOfCAKeyframeAnimationPath;

@end

@implementation mainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //使用上下文设置UIKit动画
    //[self animationOfUIKit];
    
    //通过使用代码块设置动画
    //[self animationOfBlock];
    
    //使用CABasicAnimation
    //[self animationOfCABasicAnimation ];
    
    //使用CAKeyframeAnimation动画
    [self animationOfCAKeyframeAnimation];
    
    //路径动画
//    [self animationOfCAKeyframeAnimationPath ];
    
    
    
}

-(void)animationOfUIKit
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    //开始动画
    [UIView beginAnimations:@"test" context:nil];
    //动画时长
    [UIView setAnimationDuration:1];
    /*
     *要进行动画设置的地方
     */
    
    redView.backgroundColor=[UIColor blueColor];
    redView.frame=CGRectMake(50, 50, 200, 200);
    redView.alpha=0.5;
    
    
    //动画结束
    [UIView commitAnimations];
}
-(void)animationOfBlock
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];

    [UIView animateWithDuration:1 //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionTransitionFlipFromLeft//动画效果
                     animations:^{
                         
                         //动画设置区域
                         redView.backgroundColor=[UIColor blueColor];
                         redView.frame=CGRectMake(50, 50, 200, 200);
                         redView.alpha=0.5;
                         
                     } completion:^(BOOL finish){
                       //动画结束时调用
                       //............
                     }];
    
    
}

-(void)animationOfCABasicAnimation
{
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animation];
    //设置颜色
    animation.toValue=(id)[UIColor blueColor].CGColor;
    //动画时间
    animation.duration=1;
    //是否反转变为原来的属性值
    animation.autoreverses=YES;
    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
    [self.view.layer addAnimation:animation forKey:@"backgroundColor"];
    
}

-(void)animationOfCAKeyframeAnimation
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
    //设置属性值
    animation.values=[NSArray arrayWithObjects:
                      (id)self.view.backgroundColor,
                      (id)[UIColor yellowColor],
                      (id)[UIColor greenColor],
                      (id)[UIColor blueColor],nil];
    animation.duration=1;
    animation.autoreverses=YES;
    //把关键帧添加到layer中
    [redView.layer addAnimation:animation forKey:@"backgroundColor"];
}
-(void)animationOfCAKeyframeAnimationPath
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
    CGMutablePathRef aPath=CGPathCreateMutable();
    
    CGPathMoveToPoint(aPath, nil, 20, 20);
    CGPathAddCurveToPoint(aPath, nil, 
                          160, 30,
                          220, 220, 
                          240, 380);
    
    ani.path=aPath;
    ani.duration=10;
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    ani.rotationMode=@"auto";
    [redView.layer addAnimation:ani forKey:@"position"];
    
}

#pragma mark - View lifecycle

@end
