//
//  SegmentFormCell.m
//  XLFormTest
//
//  Created by ning on 2018/3/12.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "SegmentFormCell.h"

NSString * const ZNFormRowDescriptorTypeSegment = @"ZNFormRowDescriptorTypeSegment";

@interface SegmentFormCell()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**正常按钮*/
@property (weak, nonatomic) IBOutlet UIButton *normalBtn;

/**异常按钮*/
@property (weak, nonatomic) IBOutlet UIButton *abnormalBtn;


@end

@implementation SegmentFormCell


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([SegmentFormCell class]) forKey:ZNFormRowDescriptorTypeSegment];
}

- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)update
{
    [super update];
   
    self.titleLabel.text = self.rowDescriptor.title;;
    
    switch ([self.rowDescriptor.value integerValue]) {
        case 0:
            self.normalBtn.selected = NO;
            self.abnormalBtn.selected = NO;
            break;
        case 1:
            self.normalBtn.selected = YES;
            self.abnormalBtn.selected = NO;
            break;
        case 2:
            self.normalBtn.selected = NO;
            self.abnormalBtn.selected = YES;
            break;
        default:
            break;
    }
}

- (IBAction)normalBtnClick:(id)sender {
    self.rowDescriptor.value = @"1";
    [self update];
}

- (IBAction)abnormalBtnClick:(id)sender {
    self.rowDescriptor.value = @"2";
    [self update];
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
