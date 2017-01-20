//
//  SendMailViewController.m
//  AnimationEffects
//
//  Created by cxh on 17/1/5.
//  Copyright © 2017年 cxh. All rights reserved.
//

#import "SendMailViewController.h"
//http://www.tuicool.com/articles/RjEnui
#import <MessageUI/MessageUI.h>
#import <AFNetworking.h>
#import <SKPSMTPMessage.h>
#import "NSData+Base64Additions.h"

@interface SendMailViewController () <SKPSMTPMessageDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation SendMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
}
- (IBAction)mfmail:(id)sender {
//    if (![MFMailComposeViewController canSendMail]) return;
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"周报"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"1929951122@qq.com"]];
    // 设置抄送人
    [mailCompose setCcRecipients:@[@"457360691@qq.com"]];
    
    // 设置密抄送
    [mailCompose setBccRecipients:@[@"457360691@qq.com"]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"我是邮件内容";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    //	[mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
    /**
     *  添加附件
     */
//    UIImage *image = [UIImage imageNamed:@"image"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"custom.png"];
//    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
//    NSData *pdf = [NSData dataWithContentsOfFile:file];
//    [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"7天精通IOS233333"];
    // 弹出邮件发送视图
    [self.navigationController pushViewController:mailCompose animated:YES];

}
- (IBAction)Send:(id)sender {
    SKPSMTPMessage *mail = [[SKPSMTPMessage alloc] init];
    [mail setSubject:@"我是主题"];  // 设置邮件主题
    [mail setToEmail:@"1929951122@qq.com"]; // 目标邮箱
    [mail setFromEmail:@"457360691@qq.com"]; // 发送者邮箱
    [mail setRelayHost:@"smtp.qq.com"]; // 发送邮件代理服务器
    [mail setRequiresAuth:YES];
    [mail setLogin:@"457360691@qq.com"]; // 发送者邮箱账号
    [mail setPass:@"cai19951122"]; // 发送者邮箱密码
    [mail setWantsSecure:YES];  // 需要加密
    [mail setDelegate:self];
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               @"This is a tést messåge.",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    mail.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [mail send];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma SKPSMTPMessageDelegate
-(void)messageSent:(SKPSMTPMessage *)message{

}
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{

}


@end
