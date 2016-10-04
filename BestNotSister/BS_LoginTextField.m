//
//  BS_LoginTextField.m
//  BestNotSister
//
//  Created by huhang on 16/3/23.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_LoginTextField.h"

@implementation BS_LoginTextField

//获取属性名字
+ (void)getProperties{

    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i < count; i ++) {
        //取出属性
        objc_property_t property = properties[i];
        //打印属性名字
        NSLog(@"%s <-----> %s",property_getName(property),property_getAttributes(property));
    }
    free(properties);
}

//获取成员变量
+ (void)getIvars{

    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        //取出成员变量
        Ivar ivar = ivars[i];
        //打印出成员变量
        NSLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    free(ivars);
}

- (void)awakeFromNib{

    self.tintColor = self.textColor;
    //取消第一响应者
    [self resignFirstResponder];
}

//当文本框聚焦时会调用
- (BOOL)becomeFirstResponder{

    //kvc
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super becomeFirstResponder];
}

//当文本框失去聚焦时就会调用
- (BOOL)resignFirstResponder{

   [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end
