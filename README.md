# LLRouter

项目之间的跳转路线  适用于项目之内 和各个模块项目之间的跳转 组件化管理项目

使用方式 通过pod       
 pod 'LLRouter', :git => 'https://github.com/LiGuanWen/LLRouter.git'
导入到工程中


使用是 需要先注册跳转路径文件class 一般再 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中注册
PS: 已  LLSpeedRoute 为例子
比如：    [[LLRouteManager sharedManager] registerRoute:[LLSpeedRouter class]];

创建工程中独立的 router 参考 （LLSpeedRouter）




