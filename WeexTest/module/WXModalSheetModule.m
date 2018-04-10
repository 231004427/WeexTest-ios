//
//  WXModalSheetModule.m
//  WeexTest
//
//  Created by 孙林 on 2018/4/9.
//  Copyright © 2018年 sunlin. All rights reserved.
//

#import "WXModalSheetModule.h"
@implementation WXModalSheetModule
@synthesize weexInstance;
WX_EXPORT_METHOD(@selector(toast:))
WX_EXPORT_METHOD(@selector(alert::))
@end
