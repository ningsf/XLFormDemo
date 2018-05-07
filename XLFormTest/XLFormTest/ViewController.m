//
//  ViewController.m
//  XLFormTest
//
//  Created by ning on 2018/3/9.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "ViewController.h"
#import "MyFormValidator.h"
#import "XLForm.h"
#import "InfoFormCell.h"
#import "SegmentFormCell.h"
#import "TextfildFormCell.h"
#import "ActionFormCell.h"
#import "TextViewFormCell.h"
#import <SVProgressHUD.h>
#import "SwitchFormCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"表单";
    [self initializeForm];
}

-(void)initializeForm{
    
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    XLFormRowDescriptor * pred;
    
    form = [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSectionWithTitle:@"测试表单section1"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"realExamples" rowType:ZNFormRowDescriptorTypeInfo title:@"工单编码:"];
    row.value = @"111";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"error" rowType:ZNFormRowDescriptorTypeTextfild title:@"故障位置："];
    [row.cellConfigAtConfigure setObject:@"请输入位置" forKey:@"valueTextfild.placeholder"];
    row.required = YES;  //是否必填
    [section addFormRow:row];
    
    for (NSInteger i=0; i<10; i++) {
        row = [XLFormRowDescriptor formRowDescriptorWithTag:[NSString stringWithFormat:@"%ld",(long)i] rowType:ZNFormRowDescriptorTypeInfo title:@"报修工单号"];
        if (i==0) {
            [row.cellConfigAtConfigure setObject:[UIColor redColor] forKey:@"InfoTitleLabel.textColor"];
        }
        row.value = [NSString stringWithFormat:@"266%ld",(long)i];
        [section addFormRow:row];
    }
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"status" rowType:ZNFormRowDescriptorTypeSegment title:@"设备状态:"];
    row.value = @"1";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"number" rowType:ZNFormRowDescriptorTypeTextfildInt title:@"抄表数:"];
    row.required = YES;  //是否必填
    [section addFormRow:row];
   
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"message" rowType:ZNFormRowDescriptorTypeTextView title:@""];
    [row.cellConfig setObject:@(10) forKey:@"textViewMaxNumberOfCharacters"];
    row.hidden = @YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"switch" rowType:ZNFormRowDescriptorTypeSwitch title:@"是否显示section2"];
    row.value = @1;
    pred = row;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    //写法一
    section.hidden = [NSString stringWithFormat:@"$switch==0"];
    //写法二
    section.hidden = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"$%@.value==0", pred]];
    [form addFormSection:section];
    
    // Password
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypePassword title:@"Password"];
    [row.cellConfigAtConfigure setObject:@"Required..." forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    [row addValidator:[MyFormValidator passwordValidator]];
    [section addFormRow:row];
    
    // Integer
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"int" rowType:XLFormRowDescriptorTypeInteger title:@"Integer"];
    [row.cellConfigAtConfigure setObject:@"Required..." forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"greater than 50 and less than 100" regex:@"^([5-9][0-9]|100)$"]];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"selectorPush" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Push"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"submit" rowType:ZNFormRowDescriptorTypeSubmitBtn title:@""];
    row.value = @"提交";
    row.action.formSelector = @selector(submitClick);
    [section addFormRow:row];
    
    section.footerTitle = @"foot title";
    
    self.form = form;

}

- (void)submitClick{
    
    //获取数据
    NSLog(@"formValues---%@",[self.form formValues]);
    
    //校验
    NSLog(@"errors---%@",[self formValidationErrors]);
    
    if ([self formValidationErrors].count>0) {
        [SVProgressHUD showInfoWithStatus:[[self formValidationErrors].firstObject localizedDescription]];
        return;
    }
    
    [SVProgressHUD showInfoWithStatus:@"提交成功"];
}


#pragma mark XLFormDescriptorDelegate
-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue{
    // super implmentation MUST be called
    [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    
    if ([rowDescriptor.tag isEqualToString:@"status"]) {
        XLFormRowDescriptor *textViewRowDescriptor = [self.form formRowWithTag:@"message"];
        if ([rowDescriptor.value isEqualToString:@"2"]) {
            textViewRowDescriptor.hidden = @NO;
        }else{
            textViewRowDescriptor.hidden = @YES;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
