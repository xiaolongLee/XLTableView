//
//  XLTableViewInterceptor.h
//  XLTableView
//
//  Created by 李小龙 on 2018/12/9.
//  Copyright © 2018 李小龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLTableViewInterceptor : NSObject
@property (nonatomic,weak) id receiver;
@property (nonatomic,weak) id middleMan;
@end

NS_ASSUME_NONNULL_END
