//
//  InfoFormCell.h
//  XLFormTest
//
//  Created by ning on 2018/3/10.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "XLFormBaseCell.h"

extern NSString * const ZNFormRowDescriptorTypeInfo;

@interface InfoFormCell : XLFormBaseCell

@property (weak, nonatomic) IBOutlet UILabel *InfoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *InfoValueLabel;

@end
