//
//  MDM.h
//  MDMSDK
//
/*
 * Copyright © 2012-2015 Thunder Software Technology Co., Ltd.
 * All rights reserved.
 */
//

#import <Foundation/Foundation.h>

// Defines user login info for + (void)userLogin:(NSDictionary*)LoginInfo CallBack:(void (^)(int code))CallBack;
#define USER_LOGIN_NAME           (@"userName")
#define USER_LOGIN_ASSETID        (@"assetid")
#define USER_LOGIN_PASSWORD       (@"password")

// Defines server init info for +(void)initWithServerInfo:(NSDictionary*)ServerInfo AppInfo:(NSDictionary*)AppInfo OnChangeStatus:(void(^)(int code))OnChangeStatus;
#define SERVER_URL          (@"_serverURL")
#define SERVER_PUSH_IP      (@"_pushIP")
#define SERVER_PUSH_PORT    (@"_pushPort")
#define APP_NAME            (@"_appName") //此字段只能设置成英文
#define APP_LOG_MODE        (@"_log_mode")


// Defines the login info key for getLoginInfo().
#define LAST_USER_NAME      (@"last_user_name")
#define LAST_USER_PASSCODE  (@"last_user_passcode")
#define LAST_USER_ASSETID   (@"last_user_assetid")
#define LAST_SERVER_DOMAIN  (@"last_server_domain")

enum DEVICE_STATUS{
    DEVICE_READ_ERROR = 0x10,        //状态读取错误
    DEVICE_DISCONNECTED = 0x11,      //未连接
    DEVICE_CONNECTED = 0x12,          //连接
    DEVICE_DELETED = 0x13,          //设备被删除
    DEVICE_CONNECTING = 0x14,            //正在连接
    DEVICE_OWNER_DELETED = 0x15,    //持有人被删除
    DEVICE_USER_DELETED = 0x16          //用户被删除
};

enum USER_LOGIN_STATUS{
    LOGIN_ERROR = -1,//其他失败
    LOGIN_SUCCESS = 0,//0成功
    LOGIN_NAME_OR_PASSCODE_ERROR = 1,//1用户名或密码错误
    LOGIN_USER_NOT_EXIST = 2,//2用户不存在
    LOGIN_UDID_NULL = 3,//3udid是“”
    LOGIN_ASSETID_NULL = 4,//4资产编号是“”
    LOGIN_ASSETID_INVALID = 5,//5资产编号问题（不正确、其他设备已有该资产编号、）
    LOGIN_CONNECTION_LIMITED = 6,//6服务器连接设备数达到上限
    LOGIN_DISCONNECTED = 7,//7连接不到指定网站
    LOGIN_ILLEGAL_SERVER = 8,//8非法服务器
    LOGIN_USER_SOURCE_ERROR = 9,//9服务器中用户来源数据错误
    LOGIN_INVALID_RESPONSE = 10,//10服务器返回不正确
    LOGIN_USER_OR_PASSCODE_NULL = 11,//11用户名或密码为空
    LOGIN_NO_AVAILABLE_NETWORKING = 12,//12无可用网络
    LOGIN_INVALID_DEVICE_SERIAL = 13,//13设备序列号不正确
    LOGIN_NO_DEVICE_SERIAL = 14
};

enum PROFILE_STATUS{
    PROFILE_NETWORKING_ERROR = 0X20,     //网络通信失败
    PROFILE_CHECKIN = 0X21,              //已经安装
    PROFILE_CHECKOUT = 0X22,             //未安装
    PROFILE_LOCAL_CERT_NOT_FOUND = 0x23, //本地校验的证书未找到
    PROFILE_LOCAL_CERT_ERROR = 0x24      //不是DER-encoded X.509编码的证书，(The is not a valid DER-encoded X.509 certificate.)
};

@interface MDM : NSObject
/************************************************************
 函数名称 : + (void)InitWithServerInfo:(NSDictionary*)ServerInfo
                              AppInfo:(NSDictionary*)AppInfo
                       OnChangeStatus:(void(^)(int code))OnChangeStatus;
 函数描述 : 初始化MDM
 输入参数 : InitWithServerInfo:(NSDictionary*)ServerInfo   eg: @{SERVER_URL:@"https://114.242.213.43:8443/ThundersoftMDMWeb/api",SERVER_PUSH_IP:@"114.242.213.43",SERVER_PUSH_PORT:@"8089"}
                      AppInfo:(NSDictionary*)AppInfo      eg: @{APP_NAME:@"ThunderMDM",APP_LOG_MODE:@"1"}
               OnChangeStatus:(void(^)(int code))OnChangeStatus
 Block函数 (当设备状态变化时回调 enum devicestatus)
 输出参数 : N/A
 返回参数 : (void)
 备注信息 : 此函数只能执行一次且保证原子操作（再次时仅NSLog提示）
 **********************************************************/
+ (void)initWithServerInfo:(NSDictionary*)ServerInfo
                   AppInfo:(NSDictionary*)AppInfo
            OnChangeStatus:(void(^)(int code))OnChangeStatus;


/************************************************************
 函数名称 : + (void)userLogin:(NSDictionary*)LoginInfo
 CallBack:(void (^)(int code))CallBack;
 
 函数描述 : MDM 用户登录
 输入参数 :      UserLogin:(NSDictionary*)LoginInfo             登录信息字典 @{USER_LOGIN_NAME:必填, USER_LOGIN_PASSWORD:必填, USER_LOGIN_ASSETID:选填} assetid为资产编号，企业下发的设备会有类似编号的东西
                CallBack:(void (^)(NSString* code))CallBack    登录回调（enum USER_LOGIN_STATUS）
 输出参数 : N/A
 返回参数 : (void)
 备注信息 :
 **********************************************************/
+ (void)userLogin:(NSDictionary*)LoginInfo
         CallBack:(void (^)(int code))CallBack;

/************************************************************
 函数名称 : + (void)UserLogout;
 函数描述 : MDM 用户退出
 输入参数 : (void)
 输出参数 : N/A
 返回参数 : (void)
 备注信息 :
 **********************************************************/
+ (void)userLogout;

////暂时没用
//+ (void)OpenConnectListener:(void(^)(void))_handler;

/************************************************************
 函数名称 : + (void) GetStatus;
 函数描述 : MDM 获取设备登录状态 （enum DEVICE_STATUS）
 输入参数 : (void)
 输出参数 : N/A
 返回参数 : (int) enum DEVICE_STATUS
 备注信息 :
 **********************************************************/
+ (int)getStatus;

/************************************************************
 函数名称 : + (void) profilestatus:(void(^)(int code))StatusCB
 函数描述 : MDM 获取设备Profile安装状态 （enum PROFILE_STATUS）
 输入参数 : (void)
 输出参数 : N/A
 返回参数 : (int) enum PROFILE_STATUS
 备注信息 :
 **********************************************************/
+ (void) profileStatus:(void(^)(int code))statusCB failure:(void(^)(NSError *error)) failure;

/*!
 @function profileLocalStatus
 @abstract 在本地检测MDM根配置文件是否安装，此接口需要提供服务器的CA文件（DER编码格式）。
 */
+ (enum PROFILE_STATUS) profileLocalStatus:(NSString *)name ofType:(NSString*)ext error:(NSError**)error;

/*!
 @function profileLocalStatusWithServerCA
 @abstract 从服务器请求CA证书，在本地检测根配置文件是否安装。
 @param callback - 状态回掉函数，code 取值：enum PROFILE_STATUS
 @param failure - 失败回掉
 */
+ (void) profileLocalStatusWithServerCA:(void(^)(int code)) callback failure:(void(^)(NSError*error)) failure;

/*!
 @function isProfileNeedInstall
 @abstract 结合profileStatus接口和profileLocalStatusWithServerCA接口来检测是否需要安装根证书文件。
 @param callback - 状态回掉函数，code 取值：enum PROFILE_STATUS
 @param failure - 失败回掉
 */
+ (void) isProfileNeedInstall:(void(^)(int code)) callback failure:(void(^)(NSError*error))failure;

+ (BOOL) installProfile;

/*!
 @abstract 获取用户登录记录信息，包括如下信息
 Dictionary key: LAST_USER_NAME, LAST_USER_PASSCODE, LAST_USER_ASSETID, LAST_SERVER_DOMAIN
 */
+ (NSDictionary*) getLoginInfo;

+ (BOOL) isValidIP:(NSString*)ip;

+ (BOOL) isNetworkEnable;

/*!
 @abstract 获取MDM服务器协议内容
 @param successCallBack - 成功回掉函数
 @param failureCallBack - 失败回掉
 @discussion response 目前是字典型，取出协议内容：NSString *agreement = [response valueForKey:@"result"].
 */
+ (void) getAgreement:(void (^)(id response))successCallBack
              failure:(void(^)(NSString* responseStr, NSError* error)) failureCallBack;

+ (BOOL) isAgreementOn:(NSString*)username;

+ (void) agreementOn:(NSString*)username;

+(NSString*)getDeviceUUID;

@end
