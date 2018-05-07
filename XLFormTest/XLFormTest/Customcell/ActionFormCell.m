//
//  ActionFormCell.m
//  XLFormTest
//
//  Created by ning on 2018/5/2.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "ActionFormCell.h"
#import <SVProgressHUD.h>

NSString * const ZNFormRowDescriptorTypeSubmitBtn = @"ZNFormRowDescriptorTypeSubmitBtn";

@interface ActionFormCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ActionFormCell

+(void)load{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([ActionFormCell class]) forKey:ZNFormRowDescriptorTypeSubmitBtn];
}

- (void)configure{
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.backgroundColor = [UIColor colorWithRed:59/255.0 green:154/255.0 blue:251/255.0 alpha:1.0];
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)update{
    [super update];
    self.titleLabel.text = self.rowDescriptor.value;
}

#pragma mark - cell的点击事件代理方法
- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller{
    if (self.rowDescriptor.action.formSelector){
        [controller performFormSelector:self.rowDescriptor.action.formSelector withObject:self.rowDescriptor];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
