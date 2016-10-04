//
//  BS_AddTagViewController.m
//  BestNotSister
//
//  Created by huhang on 16/5/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_AddTagViewController.h"
#import "BS_TagButton.h"
#import "BS_TagTextField.h"

@interface BS_AddTagViewController ()

//内容视图
@property (nonatomic,strong)UIView *contentView;
//输入框
@property (nonatomic,strong)UITextField *textField;
//添加按钮
@property (nonatomic,strong)UIButton *addButton;
//添加所有按钮数组
@property (nonatomic,strong)NSMutableArray *tagButtons;

@end

@implementation BS_AddTagViewController

- (NSMutableArray *)tagButtons{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addButton{
    if (!_addButton) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.width = self.contentView.width;
        addBtn.height = 35;
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.backgroundColor = [UIColor redColor];
        //让图片和文字都左对齐
        addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:addBtn];
        _addButton = addBtn;
    }
    return _addButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加导航栏
    [self setupNav];
    
    //创建内容视图
    [self setupContentView];
    
    //添加输入框
    [self setupTextfield];
}

- (void)setupTags{
 
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }

}

#pragma mark 创建内容视图
- (void)setupContentView{
    
    UIView *contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(CellMargin, 64 + CellMargin, SCREEN_WIDTH - 2 * CellMargin, SCREEN_HEIGHT);
    [self.view addSubview:contentView];
    _contentView = contentView;
}

#pragma mark 创建输入框
- (void)setupTextfield{
    
    BS_TagTextField *textField = [[BS_TagTextField alloc]init];
    textField.width = SCREEN_WIDTH - 2 * CellMargin;
    [textField addTarget:self action:@selector(textStartChange:) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)textStartChange:(UITextField *)textfield{
    
    if (textfield.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(textfield.frame) + CellMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@",textfield.text] forState:UIControlStateNormal];
    }else{
        self.addButton.hidden = YES;
    }
}

- (void)addButtonClick{
 
    BS_TagButton *tagButton = [BS_TagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    tagButton.backgroundColor = [UIColor lightGrayColor];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    [self updateTagButtonFrame];
    
    self.textField.text = nil;
    self.addButton.hidden = YES;
}

/**
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    // 更新标签按钮的frame
    for (int i = 0; i<self.tagButtons.count; i++) {
        BS_TagButton *tagButton = self.tagButtons[i];
        
        if (i == 0) { // 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { // 其他标签按钮
            BS_TagButton *lastTagButton = self.tagButtons[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + TagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) { // 按钮显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            } else { // 按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + TagMargin;
            }
        }
    }
    
    // 最后一个标签按钮
    BS_TagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + TagMargin;
    
    // 更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + TagMargin;
    }
}

/**
 * 标签按钮的点击
 */
- (void)tagButtonClick:(BS_TagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}


- (void)setupNav{

    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)done{
    NSLog(@"完成");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
