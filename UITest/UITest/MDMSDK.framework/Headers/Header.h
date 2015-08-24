//
//  Header.h
//  MDMSDK
//
/*
 * Copyright © 2012-2015 Thunder Software Technology Co., Ltd.
 * All rights reserved.
 */
//

#ifndef MDMSDK_Header_h
#define MDMSDK_Header_h

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

// Note: You may need to add the CFNetwork Framework to your project
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>

#endif

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreLocation/CoreLocation.h>

#endif
