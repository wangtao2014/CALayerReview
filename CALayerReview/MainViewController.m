//
//  MainViewController.m
//  CALayerReview
//
//  Created by wangtao on 14-3-14.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//  http://www.cnblogs.com/mjios/archive/2013/04/14/3020975.html

#import "MainViewController.h"
#import "MyLayer.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"logo"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = CGPointMake(100.0f, 100.0f);
    // 设置阴影
    // 第1行设置阴影的颜色为灰色，注意，这里使用的是UIColor的CGColor属性，是一种CGColorRef类型的数据
    // 第2行设置阴影的偏移大小，可以看出阴影往原图的右下角偏移
    // 第3行设置阴影的不透明度为0.5，表示半透明。如果为1，代表完全不透明。
    [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
    [imageView.layer setShadowOffset:CGSizeMake(10.0f, 10.0f)];
    [imageView.layer setShadowOpacity:0.5f];
    [imageView.layer setShadowRadius:5.0f];
    // 设置圆角大小
    [imageView.layer setCornerRadius:5.0f];
    [imageView.layer setMasksToBounds:YES]; // 必须加上这行代码，否则不会出现圆角效果 第2行的maskToBounds=YES：可以看做是强制内部的所有子层支持圆角效果，少了这个设置，UIImageView是不会有圆角效果的 设置了圆角属性 阴影就会消失。
    // 设置边框颜色和宽度
    [imageView.layer setBorderColor:[UIColor redColor].CGColor];
    [imageView.layer setBorderWidth:1.0f];
    // 设置旋转 利用transform属性可以设置旋转、缩放等效果
    // * M_PI_4表示四分之π，顺时针旋转45°
    // * 后面的(0, 0, 1)表示Z轴这个向量，修改这个向量可以做一些三维旋转效果，你可以随便改个值试一下，比如(1, 1, 1)
    // * 总体的意思是layer会绕着Z轴顺时针旋转45°，也就是在x、y平面进行旋转
    imageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    [self.view addSubview:imageView];
    
    // 添加一个简单的图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 10.0f;
    [self.view.layer addSublayer:layer];
    
    // 添加一个显示图片的图层
    CALayer *imageLayer = [[CALayer alloc] init];
    imageLayer.bounds = CGRectMake(0, 0, 60, 60);
    imageLayer.position = CGPointMake(100.0f, 300.0f);
    imageLayer.cornerRadius = 10.0f;
    imageLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    imageLayer.masksToBounds = YES;
    [self.view.layer addSublayer:imageLayer];
    /* 为什么CALayer中使用CGColorRef和CGImageRef这2种数据类型，而不用UIColor和UIImage？
    
    * 首先要知道：CALayer是定义在QuartzCore框架中的；CGImageRef、CGColorRef两种数据类型是定义在CoreGraphics框架中的；UIColor、UIImage是定义在UIKit框架中的
    * 其次，QuartzCore框架和CoreGraphics框架是可以跨平台使用的，在iOS和Mac OS X上都能使用，但是UIKit只能在iOS中使用
    * 因此，为了保证可移植性，QuartzCore不能使用UIImage、UIColor，只能使用CGImageRef、CGColorRef
    * 不过很多情况下，可以通过UIKit对象的特定方法，得到CoreGraphics对象，比如UIImage的CGImage方法可以返回一个CGImageRef
     */
    
    /*
     既然CALayer和UIView都能实现相同的显示效果，那究竟该选择谁好呢？
     * 其实，对比CALayer，UIView多了一个事件处理的功能。也就是说，CALayer不能处理用户的触摸事件，而UIView可以
     * 所以，如果显示出来的东西需要跟用户进行交互的话，用UIView；如果不需要跟用户进行交互，用UIView或者CALayer都可以
     * 当然，CALayer的性能会高一些，因为它少了事件处理的功能，更加轻量级
     */
    // 如果两个UIView是父子关系，那么它们内部的CALayer也是父子关系
    
    /*
     position和anchorPoint
     
     * position和anchorPoint属性都是CGPoint类型的
     
     * position可以用来设置CALayer在父层中的位置，它是以父层的左上角为坐标原点(0, 0)
     
     * anchorPoint称为"定位点"，它决定着CALayer身上的哪个点会在position属性所指的位置。它的x、y取值范围都是0~1，默认值为(0.5, 0.5)
     
     你应该已经明白anchorPoint的用途了吧，它决定着CALayer身上的哪个点会在position所指定的位置上。它的x、y取值范围都是0~1，默认值为(0.5, 0.5)，因此，默认情况下，CALayer的中点会在position所指定的位置上。当anchorPoint为其他值时，以此类推。
     */
    
    // 自定义layer1
    MyLayer *myLayer = [[MyLayer alloc] init];
    myLayer.bounds = CGRectMake(0, 0, 50, 50);
    myLayer.position = CGPointMake(25, 25);
    // 需要调用setNeedsDisplay这个方法，才会触发drawInContext:方法的调用，然后进行绘图
    [myLayer setNeedsDisplay];
    [self.view.layer addSublayer:myLayer];
    
    // 自定义layer2
    CALayer *customLayer = [CALayer layer];
    customLayer.delegate = self;
    customLayer.bounds = CGRectMake(0, 0, 50, 50);
    customLayer.position = CGPointMake(100, 100);
    // 需要调用setNeedsDisplay这个方法，才会触发drawInContext:方法的调用，然后进行绘图
    [customLayer setNeedsDisplay];
    [self.view.layer addSublayer:customLayer];
    /*
     UIView的详细显示过程
     * 当UIView需要显示时，它内部的层会准备好一个CGContextRef(图形上下文)，然后调用delegate(这里就是UIViewController)的drawLayer:inContext:方法，并且传入已经准备好的CGContextRef对象。而UIView在drawLayer:inContext:方法中又会调用自己的drawRect:方法
     
     * 平时在drawRect:中通过UIGraphicsGetCurrentContext()获取的就是由层传入的CGContextRef对象，在drawRect:中完成的所有绘图都会填入层的CGContextRef中，然后被拷贝至屏幕
     */
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    // 设置蓝色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);
    // 设置边框宽度
    CGContextSetLineWidth(ctx, 10);
    // 添加一个跟层一样大的矩形到路径中
    CGContextAddRect(ctx, layer.bounds);
    // 绘制路径
    CGContextStrokePath(ctx);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
