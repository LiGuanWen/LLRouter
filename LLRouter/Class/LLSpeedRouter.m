//
//  LLSpeedRouter.m
//  LLRouter
//
//  Created by Lilong on 2017/10/10.
//

#import "LLSpeedRouter.h"

#import "SecondViewController.h"

@implementation LLSpeedRouter


/**
 跳转前缀
 */
+(NSString *)routerName{
    return LLSPEED_SCHEME;
}

/**
 组件scheme跳转   子类重新 参考！！！！！！
 
 @param schemeUrl scheme参数
 @param dic 其他特殊参数
 */
+ (void)routerToSchemeUrl:(NSURL *)schemeUrl parameter:(NSMutableDictionary *)dic{
    UIViewController *currentVC = [dic objectForKey:CURRENT_VC_KEY];
    NSLog(@"当前页面  currvc class = %@",[currentVC class]);
    NSString *hidesBottomStr = [dic objectForKey:HIDESBOTTOMBARWHENPUSHED_KEY];
    BOOL hidesBottom;
    if ([hidesBottomStr isEqualToString:HIDESBOTTOMBARWHENPUSHED_YES]) {
        hidesBottom = YES;
    }else{
        hidesBottom = NO;
    }
    [LLSpeedRouter routerWithUrl:schemeUrl currentVC:currentVC hidesBottomBarWhenPushed:hidesBottom parameterDict:dic];
}

/**
 路径跳转
 
 @param url 跳转的url
 @param currentVC 当前跳转的UIViewController
 @param hidesBottomBarWhenPushed 是否隐藏tabbar
 @param parameterDict 需要传递的参数
 */
+ (LLSpeedRouter *)routerWithUrl:(NSURL *)url currentVC:(UIViewController *)currentVC hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed parameterDict:(NSMutableDictionary *)parameterDict{
    LLSpeedRouter *router = [[LLSpeedRouter alloc] initWithUrl:url currentVC:currentVC hidesBottomBarWhenPushed:hidesBottomBarWhenPushed parameterDict:parameterDict];
    return router;
}

- (id)initWithUrl:(NSURL *)url currentVC:(UIViewController *)currentVC hidesBottomBarWhenPushed:(BOOL)yes parameterDict:(NSMutableDictionary *)parameterDict{
    self = [super init];
    if (self) {
        self.currentVC = currentVC;
        self.linkUrl = url;
        self.hidesBottom = yes;
        self.parameterDict = parameterDict;
        [self startParsingWithUrl:url];
    }
    return self;
}

#pragma mark - 开始解析
/**
 *  开始解析
 *
 *  @param url url description
 */
-(void)startParsingWithUrl:(NSURL *)url{
    NSString *scheme = url.scheme;
    if ([scheme hasPrefix:LLSPEED_SCHEME]) {
        [self routerToModule:[LLRouter getModuleInfo:url]];
    }else if ([scheme isEqualToString:@"http"]||[scheme isEqualToString:@"https"]||[scheme isEqualToString:@"ftp"])
    {
        [self parseToOtherLinkWithUrl:url.absoluteString];
    }else if ([scheme isEqualToString:@"tel"])
    {
        [self parseToPhoneCallWithUrl:url.absoluteString];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"链接地址错误" message:url.absoluteString delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark - 解析到对应的模块
/**
 *  解析模块  (内部)
 *
 *  @param moduleInfo url description
 */
-(void)routerToModule:(LLModuleInfo*)moduleInfo{
    if ([moduleInfo.moduleName isEqualToString:@"game"]) {
        //
        [self routerToGameWithModule:moduleInfo];
    }
    
}
/**
 *  解析为外部链接
 *
 *  @param url url description
 */
-(void)parseToOtherLinkWithUrl:(NSString*)url{
    
}

/**
 *  拨打电话
 *
 *  @param url url description
 */
-(void)parseToPhoneCallWithUrl:(NSString*)url{
    UIWebView*callWebview =[[UIWebView alloc] init] ;
    NSURL *telURL =[NSURL URLWithString:url];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.currentVC.view addSubview:callWebview];
}


- (void)routerToGameWithModule:(LLModuleInfo*)moduleInfo{
    //开始
    if ([moduleInfo.page isEqualToString:@"/begin"]) {
        [LLSpeedRouter pushToGameBeginWithCurrVC:self.currentVC];
        return;
    }

}

//开始
+ (void)pushToGameBeginWithCurrVC:(UIViewController *)currVC{
    SecondViewController *vc = [[SecondViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [currVC.navigationController pushViewController:vc animated:YES];
}



@end
