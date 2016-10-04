//
//  BS_PostwordViewController.m
//  BestNotSister
//
//  Created by huhang on 16/5/18.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PostwordViewController.h"
#import "BS_PlaceholderTextView.h"
#import "BS_AddTagToolBarView.h"

@interface BS_PostwordViewController ()<UITextViewDelegate>

//文本输入框
@property (nonatomic,strong)BS_PlaceholderTextView *textView;

//工具条
@property (nonatomic,strong)BS_AddTagToolBarView *toolBarView;

@end

@implementation BS_PostwordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setupTextView];
    
    [self setupToolBarView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)setupTextView{
 
    BS_PlaceholderTextView *textView = [[BS_PlaceholderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setupToolBarView{
 
    BS_AddTagToolBarView *toolBarView = [BS_AddTagToolBarView viewFromXib];
    toolBarView.width = self.view.width;
    toolBarView.backgroundColor = [UIColor redColor];
    toolBarView.y = self.view.height - toolBarView.height;
    [self.view addSubview:toolBarView];
    self.toolBarView = toolBarView;

    [BSNotfCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notf{
  
    //键盘最终的frame
    CGRect keyboardF = [notf.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //动画持续时间
    CGFloat duration = [notf.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBarView.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - SCREEN_HEIGHT);
    }];
    
}

- (void)dealloc{
    [BSNotfCenter removeObserver:self];
}

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)setNav{

    self.title = @"发表评论";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{
    NSLog(@"%s",__func__);
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
