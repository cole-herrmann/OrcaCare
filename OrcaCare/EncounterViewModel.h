//
//  EncounterViewModel.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EncounterVMDelegate <NSObject> //delete this later in favor of RAC

- (void)encounterSyncSucceeded;

@end

@interface EncounterViewModel : NSObject

@property (nonatomic, weak) id<EncounterVMDelegate> delegate;
@property (nonatomic, strong) NSArray *encounters;

- (void)all;

+ (instancetype)singleton;

@end
