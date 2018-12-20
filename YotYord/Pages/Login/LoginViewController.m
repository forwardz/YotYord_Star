//
//  LoginViewController.m
//  YodYord
//
//  Created by Tutchavee Pongsapisuth on 9/29/2560 BE.
//  Copyright © 2560 Tutchavee Pongsapisuth. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginButton,spinnerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    loginButton.delegate = self;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"have token");
        [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
            if(user){
                //                NSLog(@"%@",user);
                //                /*
                //                MainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
                //                [self presentViewController:vc animated:NO completion:nil];
                //                 */
                [self dismissViewControllerAnimated:YES completion:nil];
//                
//                UITabBarController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"tab"];
//                [self presentViewController:tab animated:NO completion:nil];
            }else{
                NSLog(@"NO user");
                //                [loginButton setHidden:NO];
            }
        }];
    }else{
        NSLog(@"no have token");
    }
    
    /*
     อันนี้เอาไว้หน้าแรก เช็คว่ามีไหม
     if ([FIRAuth auth].currentUser) {
     // User is signed in.
     // ...
     } else {
     // No user is signed in.
     // ...
     }
     
     */
    
    
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [loginButton setHidden:YES];
    if ([FBSDKAccessToken currentAccessToken]) {
        //        // User is logged in, do work such as go to next view controller.
        //        NSLog(@"have token");
        //        [loginButton setHidden:YES];
        //        [spinnerView setHidden:NO];
        //        //        [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
        //        //            if(user){
        //        //                NSLog(@"%@",user);
        //        //                ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
        //        //                [self presentViewController:vc animated:YES completion:nil];
        //        //            }else{
        //        //                NSLog(@"NO user");
        //        //                [loginButton setHidden:NO];
        //        //            }
        //        //        }];
    }else{
        NSLog(@"no have token");
        [spinnerView setHidden:YES];
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"didCompleteWithResult");
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError]; /// logout
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    NSLog(@"didCompleteWithResult");
    [spinnerView setHidden:NO];
    if(error){
        [spinnerView setHidden:YES];
    }else if(result.isCancelled){
        [spinnerView setHidden:YES];
    }else{
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
        [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (error) {
                NSLog(@"sign in firebase error");
                [self.spinnerView setHidden:YES];
                return;
            }
            FIRUser *user = authResult.user;
            NSLog(@"%@",user.displayName);
            NSLog(@"%@",user.photoURL);
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
       
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

@end
