//
//  XLTableViewInterceptor.m
//  XLTableView
//
//  Created by 李小龙 on 2018/12/9.
//  Copyright © 2018 李小龙. All rights reserved.
//

#import "XLTableViewInterceptor.h"

@implementation XLTableViewInterceptor
#pragma mark - forward & response override
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.middleMan respondsToSelector:aSelector]) return self.middleMan;
    if ([self.receiver respondsToSelector:aSelector]) return self.receiver;
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.middleMan respondsToSelector:aSelector]) return YES;
    if ([self.receiver respondsToSelector:aSelector]) return YES;
    return [super respondsToSelector:aSelector];
}

@end
