//
//  AddViewController.h
//  MyKeyChainDemo
//
//  Created by LGJ on 2017/11/21.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UIButton *SaveBtn;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@end
