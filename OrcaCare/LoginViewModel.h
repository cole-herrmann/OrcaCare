//
//  LoginViewModel.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginVMDelegate <NSObject> //delete this later in favor of RAC

- (void)loginSucceeded;

@end

@interface LoginViewModel : NSObject

@property (nonatomic, weak) id<LoginVMDelegate> delegate;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password;

@end
