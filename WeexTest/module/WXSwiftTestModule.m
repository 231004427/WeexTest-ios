//
//  WXSwiftTestModule.m
//  WeexTest
//
//  Created by 孙林 on 2018/3/3.
//  Copyright © 2018年 sunlin. All rights reserved.
//

#import "WXSwiftTestModule.h"
#import "WeexTest-Swift.h"
@implementation WXSwiftTestModule
@synthesize weexInstance;
#pragma clang diagnostic push //关闭unknow selector的warrning
#pragma clang diagnostic ignored "-Wundeclared-selector"

WX_EXPORT_METHOD(@selector(printLog::)) //Swift 中定义的方法，XCode 转换成的最终的方法名称，在`WeexDemo-Swift.h`里面查看
WX_EXPORT_METHOD(@selector(reload))
#pragma clang diagnostic pop

@end
