//
//  InfoFormCell.m
//  XLFormTest
//
//  Created by ning on 2018/3/10.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "InfoFormCell.h"

NSString * const ZNFormRowDescriptorTypeInfo = @"ZNFormRowDescriptorTypeInfo";

@implementation InfoFormCell

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([InfoFormCell class]) forKey:ZNFormRowDescriptorTypeInfo];
}

- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)update
{
    [super update];
    self.InfoTitleLabel.text = self.rowDescriptor.title;
    self.InfoValueLabel.text = [NSString stringWithFormat:@"%@",self.rowDescriptor.value];
    
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
