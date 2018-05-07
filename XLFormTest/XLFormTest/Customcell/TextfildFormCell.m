//
//  TextfildFormCell.m
//  XLFormTest
//
//  Created by ning on 2018/3/13.
//  Copyright © 2018年 ning. All rights reserved.
//

#import "TextfildFormCell.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LS_LINKER_TITLE_COLOR (UIColorFromRGB(0x5fa2d1))

NSString * const ZNFormRowDescriptorTypeTextfild = @"ZNFormRowDescriptorTypeTextfild";

NSString * const ZNFormRowDescriptorTypeTextfildInt = @"ZNFormRowDescriptorTypeTextfildInt";

@interface TextfildFormCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *valueTextfild;

@end

@implementation TextfildFormCell


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([TextfildFormCell class]) forKey:ZNFormRowDescriptorTypeTextfild];
    
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([TextfildFormCell class]) forKey:ZNFormRowDescriptorTypeTextfildInt];
}

- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.valueTextfild.layer.borderWidth = 1;
    self.valueTextfild.layer.borderColor = LS_LINKER_TITLE_COLOR.CGColor;
    [self.valueTextfild addTarget:self
                  action:@selector(textFieldDidChangeValue:)
        forControlEvents:UIControlEventEditingChanged];
}

- (void)update{
    [super update];
    self.titleLabel.text = self.rowDescriptor.title;;
    self.valueTextfild.text = self.rowDescriptor.value;
    if ([self.rowDescriptor.rowType isEqualToString:ZNFormRowDescriptorTypeTextfildInt]){
        self.valueTextfild.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)textFieldDidChangeValue:(id)sender{
    self.rowDescriptor.value = ((UITextField *)sender).text;
}

-(BOOL)formDescriptorCellCanBecomeFirstResponder{
    return YES;
}

-(BOOL)formDescriptorCellBecomeFirstResponder{
    return [self.valueTextfild becomeFirstResponder];
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
