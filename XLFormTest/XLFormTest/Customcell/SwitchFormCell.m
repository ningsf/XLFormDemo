//
//  SwitchFormCell.m
//  XLFormTest
//
//  Created by ning on 2018/5/3.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "SwitchFormCell.h"

NSString * const ZNFormRowDescriptorTypeSwitch = @"ZNFormRowDescriptorTypeSwitch";

@interface SwitchFormCell()

@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SwitchFormCell

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([SwitchFormCell class]) forKey:ZNFormRowDescriptorTypeSwitch];
}


- (void)configure
{
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.switchControl addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)update
{
    [super update];
    self.titleLabel.text = self.rowDescriptor.title;
    self.switchControl.on = [self.rowDescriptor.value boolValue];
    self.switchControl.enabled = !self.rowDescriptor.isDisabled;
}

- (void)valueChanged
{
    self.rowDescriptor.value = @(self.switchControl.on);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
