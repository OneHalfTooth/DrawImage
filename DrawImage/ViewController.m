//
//  ViewController.m
//  DrawImage
//
//  Created by 马扬 on 2017/9/2.
//  Copyright © 2017年 mayang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+QR.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIImage *) createImage{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    /** 获取当前上下文 */
    CGContextRef context = UIGraphicsGetCurrentContext();
    /** 填充颜色 */
    CGContextSetRGBFillColor(context, 235 / 255.0, 235 / 255.0, 235 / 255.0, 1);
    /** 填充区域 */
    CGContextFillRect(context, self.view.bounds);
    
    
    /** 白色区域填充 */
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(20, 118, self.view.bounds.size.width - 40, self.view.bounds.size.width - 40));
    
    UIImage * drawImage = [@"https://github.com/OneHalfTooth" saveQRImageBySize:CGSizeMake(self.view.bounds.size.width - 60, self.view.bounds.size.width - 60)];
    [drawImage drawInRect:CGRectMake(30, 128, drawImage.size.width, drawImage.size.height)];
    
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /** 通过字符换行 */
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    NSString * title = @"快去Stars吧";
    //绘制文字
    [title drawInRect:CGRectMake(10, self.view.bounds.size.width + 86 + 30, self.view.bounds.size.width - 20, 40) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:28],NSForegroundColorAttributeName:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    /** 添加边框 */
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(self.view.bounds.size.width / 2 - 32, (self.view.bounds.size.width / 2 - 60) -2 + 128,64, 64)];
    [[UIColor whiteColor] setFill];
    [path fill];
    
    /** 绘制中心图案 */
    UIImage * drawCenterImage = [UIImage imageNamed:@"256x256"];
    [drawCenterImage drawInRect:CGRectMake(self.view.bounds.size.width / 2 - 30, (self.view.bounds.size.width / 2 - 60) + 128,60, 60)];
    
    /** 绘制用户头衔 */
    UIImage * userImage = [UIImage imageNamed:@"256x256"];
    [userImage drawInRect:CGRectMake(20, 40, 60, 60)];
    
    /** 添加用户名 */
    NSString * userName = @"OneHalf";
    paragraphStyle.alignment = 0;
    [userName drawAtPoint:CGPointMake(100, 45) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    
    NSString * contentText = @"欢迎点赞.....欢迎点赞.....欢迎点赞.....欢迎点赞.....欢迎点赞.....欢迎点赞.....";
    
    CGRect frame = [contentText boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    paragraphStyle.alignment = 1;
    [contentText drawInRect:CGRectMake(10, self.view.bounds.size.height - 50 - frame.size.height, frame.size.width, frame.size.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageVIew.image = image;
    return image;
}


- (IBAction)saveButton:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum([self createImage], self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
   
    
}
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo{
    
    NSString * title = @"保存成功";
    if (error) {
        title = @"保存失败";
    }
    [[[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
