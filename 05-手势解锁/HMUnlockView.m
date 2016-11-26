//
//  HMUnlockView.m
//  05-手势解锁
//
//  Created by JackMeng on 2016/11/10.
//  Copyright © 2016年 JackMeng. All rights reserved.
//

#import "HMUnlockView.h"

@interface HMUnlockView ()
@property (nonatomic,strong) NSMutableArray * selectedButtons;

@property (nonatomic,assign) CGPoint currentPoint;
@end

@implementation HMUnlockView

- (NSMutableArray *)selectedButtons
{
    if (_selectedButtons == nil)
    {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void) setupUI
{
    // 创建九个按钮
    for (int i = 0; i < 9; i++)
    {
        UIButton * button = [[UIButton alloc] init];
        
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateHighlighted];
        button.userInteractionEnabled = NO;
        
        [self addSubview:button];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    //获取触摸位置
    CGPoint locP = [touch locationInView:touch.view];
    
    for (int i = 0; i < self.subviews.count; i++)
    {
        UIButton * button = self.subviews[i];
        if (CGRectContainsPoint(button.frame, locP) && button.selected == NO)
        {
            button.selected = YES;
            
            [self.selectedButtons addObject:button];
            
            break;
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    self.currentPoint = [touch locationInView:touch.view];
    [self touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.userInteractionEnabled = NO;
    self.currentPoint = [[self.selectedButtons lastObject] center];
    [self setNeedsDisplay];
    NSMutableString * pwdStr = [NSMutableString string];
    for (int i = 0; i < self.selectedButtons.count; i++)
    {
        UIButton * button = self.selectedButtons[i];
        [pwdStr appendFormat:@"%@",@(button.tag)];
    }
    
    if ([self.delegate respondsToSelector:@selector(unlockView:withPwd:)])
    {
        if ([self.delegate unlockView:self withPwd:pwdStr])
        {
            [self clear];
            self.userInteractionEnabled = YES;
        }
        else
        {
            for (int i = 0; i < self.selectedButtons.count; i++)
            {
                UIButton * button = self.selectedButtons[i];
                button.highlighted = YES;
                button.selected = NO;
            }
            //清除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self clear];
                
                self.userInteractionEnabled = YES;
            });
        }
    }
    
    
}
- (void) clear
{
    //按钮状态
    for (int i = 0; i < self.selectedButtons.count; i++)
    {
        UIButton * button = self.selectedButtons[i];
        button.selected = NO;
        button.highlighted = NO;
    }
    
    [self.selectedButtons removeAllObjects];
    
    [self setNeedsDisplay];
}

//布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    int totleColume = 3;
    CGSize size = self.frame.size;
    CGFloat marginX = (size.width - totleColume * btnW) / (totleColume +1);
    CGFloat marginY = (size.height - totleColume * btnH) / (totleColume +1);
    
    for (int i = 0; i < self.subviews.count; i++)
    {
        int row = i / totleColume;
        int colume = i % totleColume;
        CGFloat x = marginX + colume * (marginX + btnW);
        CGFloat y = marginY + row * (marginY + btnH);
        UIButton * btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnW, btnH);
        
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    //判断数组
    if (self.selectedButtons.count == 0) {
        return;
    }
    // Drawing code
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    path.lineWidth = 5;
    
    [[UIColor whiteColor] set];
    
    path.lineCapStyle = kCGLineCapRound;
    
    path.lineJoinStyle = kCGLineJoinRound;
    
    for (int i = 0; i < self.selectedButtons.count; i++)
    {
        //获取按钮中心点
        UIButton * button = self.selectedButtons[i];
        
        if (i == 0)
        {
            [path moveToPoint:button.center];
        }
        else
        {
            [path addLineToPoint:button.center];
        }
    }
    
    //再加一根线
    [path addLineToPoint:self.currentPoint];
    
    
    [path stroke];
}


@end
