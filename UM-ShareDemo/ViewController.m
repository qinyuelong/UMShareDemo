//
//  ViewController.m
//  UM-ShareDemo
//
//  Created by snqu-qin on 17/2/27.
//  Copyright © 2017年 snqu. All rights reserved.
// http://dev.umeng.com/social/ios/login-page
// http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#2


#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 微信分享到会话
- (IBAction)wechatMessageShareAction:(id)sender {
//    [self shareTextToPlatformType:UMSocialPlatformType_WechatSession withMessage:@"微信文本分享测试"];
    UIImage *thumbImage = [UIImage imageNamed:@"thumbImage.png"];
    NSString *imageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488193160550&di=0af2fbb501ad25649f94d44fe83a885b&imgtype=0&src=http%3A%2F%2Fwww.wallcoo.com%2Fanimal%2FDogs_Summer_and_Winter%2Fwallpapers%2F1920x1200%2FDogsB10_Lucy.jpg";
    [self shareImageToPlatformType:UMSocialPlatformType_WechatSession thumbImage:thumbImage sourceImagePath:imageURL];
}

#pragma mark - 微信分享到朋友圈
- (IBAction)wechatSpaceShareAction:(id)sender {
//    [self shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine withMessage:@"微信文本分享测试"];
    UIImage *thumbImage = [UIImage imageNamed:@"thumbImage"];
    NSString *imageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488193160550&di=0af2fbb501ad25649f94d44fe83a885b&imgtype=0&src=http%3A%2F%2Fwww.wallcoo.com%2Fanimal%2FDogs_Summer_and_Winter%2Fwallpapers%2F1920x1200%2FDogsB10_Lucy.jpg";
    [self shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine thumbImage:thumbImage sourceImagePath:imageURL];
}

#pragma mark - 微信登录
- (IBAction)wechatLoginAction:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}


#pragma mark - QQ分享到会话
- (IBAction)tencentMessageShareAction:(id)sender {
//    [self shareTextToPlatformType:UMSocialPlatformType_QQ withMessage:@"QQ文本分享测试"];
    UIImage *thumbImage = [UIImage imageNamed:@"thumbImage"];
    NSString *imageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488193160550&di=0af2fbb501ad25649f94d44fe83a885b&imgtype=0&src=http%3A%2F%2Fwww.wallcoo.com%2Fanimal%2FDogs_Summer_and_Winter%2Fwallpapers%2F1920x1200%2FDogsB10_Lucy.jpg";
    [self shareImageToPlatformType:UMSocialPlatformType_QQ thumbImage:thumbImage sourceImagePath:imageURL];
}

#pragma mark - QQ分享到朋友圈
- (IBAction)tencentSpaceShareAction:(id)sender {
//    [self shareTextToPlatformType:UMSocialPlatformType_Qzone withMessage:@"QQ文本分享测试"];
    
    UIImage *thumbImage = [UIImage imageNamed:@"thumbImage"];
    NSString *imageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488193160550&di=0af2fbb501ad25649f94d44fe83a885b&imgtype=0&src=http%3A%2F%2Fwww.wallcoo.com%2Fanimal%2FDogs_Summer_and_Winter%2Fwallpapers%2F1920x1200%2FDogsB10_Lucy.jpg";
    [self shareImageToPlatformType:UMSocialPlatformType_Qzone thumbImage:thumbImage sourceImagePath:imageURL];
    
}

#pragma mark - QQ登录
- (IBAction)tencentLoginAction:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

#pragma mark - 新浪微博分享
- (IBAction)sinaShareAction:(id)sender {
    
    
}

#pragma mark - 新浪微博登录
- (IBAction)sinaLoginAction:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
}


#pragma mark - 登录获取用户信息

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

#pragma mark - 分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType withMessage:(NSString *)message{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = message;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - 分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType thumbImage:(UIImage *)thumbImage sourceImagePath:(NSString *)imageUrlStr{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = thumbImage;
    [shareObject setShareImage:imageUrlStr];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark -   分享图文（新浪支持，微信/QQ仅支持图或文本分享）
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:@"https://www.umeng.com/img/index/demo/1104.4b2f7dfe614bea70eea4c6071c72d7f5.jpg"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


#pragma mark -  分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark -  分享音乐
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark -  分享视频

- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
