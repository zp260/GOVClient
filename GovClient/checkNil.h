//
//  checkNil.h
//  GovClient
//
//  Created by mrz on 16/1/21.
//  Copyright © 2016年 pipi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface checkNil : NSString

-(NSString*)convertNull:(id)object;
-(BOOL)isNull:(id)object;

@end
