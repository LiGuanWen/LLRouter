//
//  LLSpeedRouter.h
//  LLRouter
//
//  Created by Lilong on 2017/10/10.
//

#import <Foundation/Foundation.h>
#import "LLRouter.h"

#define LLSPEED_SCHEME @"llspeed"

//开始页面
static NSString *const llspeed_routeWithBegin = @"llspeed://game/begin";


@interface LLSpeedRouter : NSObject
@property (nonatomic,strong) UIViewController *currentVC; //跳转的VC
@property (nonatomic,strong) NSURL *linkUrl; //链接地址
@property (nonatomic,assign) BOOL isPush; //是否跳转页面
@property (nonatomic,assign) BOOL hidesBottom; //是否跳转页面
@property (nonatomic,strong) NSMutableDictionary *parameterDict; //对象参数

/**
 路径跳转
 
 @param url 跳转的url
 @param currentVC 当前跳转的UIViewController
 @param hidesBottomBarWhenPushed 是否隐藏tabbar
 @param parameterDict 需要传递的参数
 */
+ (LLSpeedRouter *)routeWithUrl:(NSURL *)url currentVC:(UIViewController *)currentVC hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed parameterDict:(NSMutableDictionary *)parameterDict;
@end
