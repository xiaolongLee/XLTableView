//
//  XLTableView.m
//  XLTableView
//
//  Created by 李小龙 on 2018/12/9.
//  Copyright © 2018 李小龙. All rights reserved.
//

#import "XLTableView.h"
#import "XLTableViewInterceptor.h"

@interface XLTableView ()
@property (nonatomic,strong) XLTableViewInterceptor *dataSourceInterceptor;
@property (nonatomic,assign) NSInteger actualRows;
@end

@implementation XLTableView

- (void)layoutSubviews{
    [self resetContentOffestIfNeeded];
    [super layoutSubviews];
}

- (void)resetContentOffestIfNeeded {
    CGPoint contentOffset = self.contentOffset;
    //scroll over top
    if (contentOffset.y < 0.0) {
        contentOffset.y = self.contentSize.height / 3.0;
    }
    // scroll over bottom
    else if (contentOffset.y >= (self.contentSize.height - self.bounds.size.height)) {
        contentOffset.y = self.contentSize.height / 3.0 - self.bounds.size.height;
    }
    [self setContentOffset:contentOffset];
}

#pragma mark - DataSource Delegate Setter/Getter Override
- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    self.dataSourceInterceptor.receiver = dataSource;
    [super setDataSource:(id<UITableViewDataSource>)self.dataSourceInterceptor];
}

- (XLTableViewInterceptor *)dataSourceInterceptor {
    if (!_dataSourceInterceptor) {
        _dataSourceInterceptor = [[XLTableViewInterceptor alloc] init];
        _dataSourceInterceptor.middleMan = self;
    }
    
    return _dataSourceInterceptor;
}

#pragma mark -Delegate Method Override
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    self.actualRows = [self.dataSourceInterceptor.receiver tableView:tableView numberOfRowsInSection:section];
    return self.actualRows * 3;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * actualIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    return [self.dataSourceInterceptor.receiver tableView:tableView cellForRowAtIndexPath:actualIndexPath];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
