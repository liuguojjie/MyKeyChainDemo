//
//  AddViewController.m
//  MyKeyChainDemo
//
//  Created by LGJ on 2017/11/21.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "AddViewController.h"
#import "LGJKeyChainTools.h"

static NSString * const service = @"MyKeyChainDemo";

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userNameText.text = self.username;
    self.passwordText.text = self.password;
}
- (IBAction)saveAction:(id)sender {
    
    if (self.userNameText.text == nil || [self.userNameText.text length] == 0) {
        
        [self alertShow:@"用户名不能为空"];
        
        return;
    }
    
    if (self.passwordText.text == nil||[self.passwordText.text length] == 0) {
        
        [self alertShow:@"密码不能为空"];
        
        return;
    }
    
   BOOL SAVE = [LGJKeyChainTools setObject:self.passwordText.text forService:service account:self.userNameText.text];
    
    if (SAVE) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)alertShow:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
