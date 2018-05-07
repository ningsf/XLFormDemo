//
//  TextViewFormCell.m
//  PropertyManager
//
//  Created by ning on 2018/3/15.
//  Copyright © 2018年 优思科技. All rights reserved.
//

#import "TextViewFormCell.h"
#import "XLFormTextView.h"
NSString * const ZNFormRowDescriptorTypeTextView = @"ZNFormRowDescriptorTypeTextView";


@interface TextViewFormCell()<UITextViewDelegate>

@property (strong, nonatomic) XLFormTextView *textView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,assign) NSNumber *textViewMaxNumberOfCharacters;

@end

@implementation TextViewFormCell


+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([TextViewFormCell class]) forKey:ZNFormRowDescriptorTypeTextView];
}


- (void)configure
{
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textView = [[XLFormTextView alloc]initWithFrame:CGRectMake(10, 0, self.contentView.frame.size.width, 80)];
    [self.bgView addSubview: self.textView];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor blueColor].CGColor;
    self.textView.delegate = self;
}

- (void)update
{
    [super update];
    self.textView.text = self.rowDescriptor.value;
}


#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.formViewController beginEditing:self.rowDescriptor];
    return [self.formViewController textViewDidBeginEditing:textView];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.textView.text length] > 0) {
        self.rowDescriptor.value = self.textView.text;
    } else {
        self.rowDescriptor.value = nil;
    }
    [self.formViewController endEditing:self.rowDescriptor];
    [self.formViewController textViewDidEndEditing:textView];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return [self.formViewController textViewShouldBeginEditing:textView];
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([self.textView.text length] > 0) {
        self.rowDescriptor.value = self.textView.text;
    } else {
        self.rowDescriptor.value = nil;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.textViewMaxNumberOfCharacters) {
        // Check maximum length requirement
        NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (newText.length > self.textViewMaxNumberOfCharacters.integerValue) {
            return NO;
        }
    }
    return YES;
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
