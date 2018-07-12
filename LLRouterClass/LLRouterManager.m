//
//  LLRouterManager.m
//  LLRouter
//
//  Created by Lilong on 2017/10/10.
//

#import "LLRouterManager.h"

@implementation LLRouterManager


+ (instancetype)sharedManager{
    static LLRouterManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[LLRouterManager alloc] init];
        
    });
    return _manager;
}

- (NSMutableDictionary *)routerDict{
    if (!_routerDict) {
        _routerDict = [[NSMutableDictionary alloc] init];
    }
    return _routerDict;
}


/**
 路线注册  存在在字典中
 
 注意 注册的路径需要存在这个方法
 +(NSString *)routeName
 {
 return ROUTE_NAME;
 }

 @param routerClass 路径文件类型
 */
- (void)registerRouter:(Class)routerClass{
    if (routerClass) {
        NSString *routerName = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        SEL routeNameSelector = @selector(routeName);
#pragma clang diagnostic pop
        if(routerClass && [routerClass respondsToSelector:routeNameSelector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            routerName = [routerClass performSelector:routeNameSelector];//获取组件名
#pragma clang diagnostic pop
        }
        if (routerName) {
            [self.routerDict setObject:routerClass forKey:routerName];
        }
        NSLog(@"注册的路径名称为 =%@  路径文件为 = %@",routerName,routerClass);
    }
}
@end
