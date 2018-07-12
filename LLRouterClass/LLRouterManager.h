//
//  LLRouterManager.h
//  LLRouter
//
//  Created by Lilong on 2017/10/10.
//

#import <Foundation/Foundation.h>

@interface LLRouterManager : NSObject


/**
 存储路径信息  key 路径host  vlaue 路径的文件class
 */
@property (strong, nonatomic) NSMutableDictionary *routerDict;


+ (instancetype)sharedManager;

/**
 路线注册  存在在字典中
 
 注意 注册的路径需要存在这个方法
 +(NSString *)routeName
 {
 return ROUTE_NAME;
 }
 
 @param routerClass 路径文件类型
 */
- (void)registerRouter:(Class)routerClass;
@end
