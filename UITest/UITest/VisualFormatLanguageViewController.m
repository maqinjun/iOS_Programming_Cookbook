//
//  VisualFormatLanguageViewController.m
//  UITest
//
//  Created by maqj on 15/6/25.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "VisualFormatLanguageViewController.h"

@interface VisualFormatLanguageViewController ()
@property (nonatomic, strong) UITextField *textFieldEmail;
@property (nonatomic, strong) UITextField *textFieldConfirmEmail;
@property (nonatomic, strong) UIButton *registerButton;
@end

/* Email Text Field Constraints*/
NSString *const kEmailTextFieldHorizontal = @"H:|-[_textFieldEmail]-|";
NSString *const kEmailTextFieldVertical = @"V:|-70-[_textFieldEmail]";

/* Confirm Email Text Field Constraints*/
NSString *const kConfirmEmailHorizontal = @"H:|-[_textFieldConfirmEmail]-|";
NSString *const kConfirmEmailVertical = @"V:[_textFieldEmail]-[_textFieldConfirmEmail]";

/* Register Button Constraint*/
NSString *const kRegisterVertical = @"V:[_textFieldConfirmEmail]-[_registerButton]";

@implementation VisualFormatLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];

    [self constructUIComponents];
    [self addComponentToView:self.view];
    [self.view addConstraints:[self constrains]];
}

-(void)done:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [_textFieldConfirmEmail resignFirstResponder];
//    [self resignFirstResponder];
    [_textFieldEmail resignFirstResponder];
}

-(UITextField*)textFieldWithPlaceholder:(NSString*)placeholder{
    UITextField *result = [[UITextField alloc] init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    result.borderStyle = UITextBorderStyleRoundedRect;
    result.placeholder = placeholder;
    return result;
}

-(void)constructUIComponents{
    self.textFieldEmail = [self textFieldWithPlaceholder:@"Email"];
    self.textFieldConfirmEmail = [self textFieldWithPlaceholder:@"Confirm Email"];
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.registerButton setTitle:@"Register" forState:UIControlStateNormal];
}

-(void)addComponentToView:(UIView*)view{
    [view addSubview:self.textFieldConfirmEmail];
    [view addSubview:self.textFieldEmail];
    [view addSubview:self.registerButton];
}

-(NSArray*)emailTextFieldConstraints{
    NSMutableArray *result = [NSMutableArray array];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_textFieldEmail);
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kEmailTextFieldHorizontal
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kEmailTextFieldVertical
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDictionary]];
    return [NSArray arrayWithArray:result];
}

-(NSArray*)confirmEmailTextFieldConstraints{
    NSMutableArray *result = [NSMutableArray array];
    
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(_textFieldConfirmEmail, _textFieldEmail);
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailHorizontal
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDic]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailVertical
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDic]];
    
    return [NSArray arrayWithArray:result];
}

-(NSArray*)registerButtonConstraints{
    NSMutableArray *result = [NSMutableArray array];
    
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(_registerButton, _textFieldConfirmEmail);
    
    [result addObject:[NSLayoutConstraint constraintWithItem:self.registerButton
                                                   attribute:NSLayoutAttributeCenterX
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.view
                                                   attribute:NSLayoutAttributeCenterX
                                                  multiplier:1.0f
                                                    constant:0.0f]];

    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kRegisterVertical
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDic]];
    
    return [NSArray arrayWithArray:result];
}

-(NSArray*)constrains{
    NSMutableArray *result = [NSMutableArray array];
    
    [result addObjectsFromArray:[self emailTextFieldConstraints]];
    [result addObjectsFromArray:[self confirmEmailTextFieldConstraints]];
    [result addObjectsFromArray:[self registerButtonConstraints]];
    
    return [NSArray arrayWithArray:result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
