//
//  MyFormValidator.h
//  XLFormTest
//
//  Created by ning on 2018/5/2.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "XLFormValidatorProtocol.h"

@interface MyFormValidator : NSObject<XLFormValidatorProtocol>
+(MyFormValidator *)passwordValidator;
@end
