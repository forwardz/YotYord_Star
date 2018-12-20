//
//  LoginViewController.h
//  YodYord
//
//  Created by Tutchavee Pongsapisuth on 9/29/2560 BE.
//  Copyright © 2560 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *spinnerView;

@end
