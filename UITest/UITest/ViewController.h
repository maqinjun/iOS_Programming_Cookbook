//
//  ViewController.h
//  UITest
//
//  Created by maqj on 15/4/14.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *mUUIDTextFiledView;
@property (nonatomic, weak) IBOutlet UITextView *mTextView;
@property (nonatomic, weak) IBOutlet UIToolbar *mToolBar;
@property (nonatomic, weak) IBOutlet UIProgressView *mProgressView;

@property (nonatomic, weak) IBOutlet UITextField *testFeild;

-(IBAction)download:(id)sender;

-(IBAction)undo:(id)sender;

@end

