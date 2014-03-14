//
//  MyLayer.m
//  CALayerReview
//
//  Created by wangtao on 14-3-14.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "MyLayer.h"

@implementation MyLayer

- (void)drawInContext:(CGContextRef)ctx
{
    // 设置为红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 设置起点
    CGContextMoveToPoint(ctx, 50, 0);
    // 连接(50, 0)到(0, 50)
    CGContextAddLineToPoint(ctx, 0, 50);
    // 连接(0, 50)到(50, 50)
    CGContextAddLineToPoint(ctx, 50, 50);
    // 连接(50, 0)到(50, 50) 终点和起点
    CGContextClosePath(ctx);
    // 绘制路径
    CGContextFillPath(ctx);
}

@end
