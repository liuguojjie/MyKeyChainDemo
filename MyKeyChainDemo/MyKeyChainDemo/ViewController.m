//
//  ViewController.m
//  MyKeyChainDemo
//
//  Created by LGJ on 2017/11/21.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "ViewController.h"
#import "LGJKeyChainTools.h"
#import "AddViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *keyChainArr;

@end

@implementation ViewController

static NSString * const service = @"MyKeyChainDemo";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //查询所有keychain Item
    NSArray *arr = [LGJKeyChainTools findAccountWithService:service];
    
    self.keyChainArr = [NSMutableArray arrayWithArray:arr];
    
    [self.myTableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.keyChainArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LGJKeyChainQuery *query = self.keyChainArr[indexPath.row];
    
    cell.textLabel.text = query.account;
    
    //根据Account 查询密码
    NSString *password = [LGJKeyChainTools objectForService:service account:query.account];
    
    cell.detailTextLabel.text = password;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LGJKeyChainQuery *query = self.keyChainArr[indexPath.row];
    
    NSString *password = [LGJKeyChainTools objectForService:service account:query.account];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddViewController *addVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    
    NSLog(@"account == %@",query.account);
    NSLog(@"password == %@",password);
    
    addVc.username = query.account;
    addVc.password = password;
    
    [self.navigationController pushViewController:addVc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
         LGJKeyChainQuery *query = self.keyChainArr[indexPath.row];
    
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            BOOL Delete = [LGJKeyChainTools deleteObjectForService:service account:query.account];
            
            if (Delete) {
               [self.keyChainArr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            }
        
        }
    
}

@end
