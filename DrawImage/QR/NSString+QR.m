//
//  NSString+QR.m
//  DrawImage
//
//  Created by 马扬 on 2017/9/2.
//  Copyright © 2017年 mayang. All rights reserved.
//

#import "NSString+QR.h"


@implementation NSString (QR)


- (UIImage *)saveQRImageBySize:(CGSize)size{
    
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage * ciimage = [filter outputImage];
    
    CGRect extent = ciimage.extent;
    CGFloat scale = MIN(size.width / extent.size.width, size.height / extent.size.height);
    CGFloat width = extent.size.width * scale;
    CGFloat height = extent.size.height * scale;
    
    
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciimage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef saledImage = CGBitmapContextCreateImage(bitmapRef);
    
    UIImage * QRImage = [UIImage imageWithCGImage:saledImage];
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return QRImage;
}

@end
