//
//  AddPersonViewController.m
//  UITest
//
//  Created by maqj on 15/7/14.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AppDelegate.h"
#import "Person.h"

@interface AddPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameView;
@property (weak, nonatomic) IBOutlet UITextField *lastNameView;
@property (weak, nonatomic) IBOutlet UITextField *ageView;

@end

@implementation AddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
  
}

- (void)initView{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(handleDone:)];
    self.ageView.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)handleDone:(id)sender{
    
    if (self.firstNameView.text.length <= 0 &&
        self.lastNameView.text.length <= 0) {
        return;
    }
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *mgContext = delegate.managedObjectContext;
    
    Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:mgContext];
    
    if (newPerson) {
        newPerson.firstName = self.firstNameView.text;
        newPerson.lastName = self.lastNameView.text;
        newPerson.age = @([self.ageView.text integerValue]);
        
        NSError *error = nil;
        
        if ([mgContext save:&error]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"Failed to save the context: %@", error);
        }
    }
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
