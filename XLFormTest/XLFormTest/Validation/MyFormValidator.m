//
//  MyFormValidator.m
//  XLFormTest
//
//  Created by ning on 2018/5/2.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "MyFormValidator.h"
#import "XLFormValidationStatus.h"
#import "XLFormRegexValidator.h"

@implementation MyFormValidator

//必须要实现的协议方法
-(XLFormValidationStatus *)isValid:(XLFormRowDescriptor *)row
{
    return [XLFormValidationStatus formValidationStatusWithMsg:nil status:YES rowDescriptor:row];
}


#pragma mark - Validators

+(XLFormValidator *)passwordValidator
{
    return [XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:@"^(?=.*\\d)(?=.*[A-Za-z]).{6,32}$"];
}


@end
