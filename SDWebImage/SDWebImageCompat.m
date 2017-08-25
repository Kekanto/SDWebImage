/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompat.h"

#import "objc/runtime.h"

#if !__has_feature(objc_arc)
#error SDWebImage is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

inline UIImage *SDScaledImageForKey(NSString * _Nullable key, UIImage * _Nullable image) {
    if (!image) {
        return nil;
    }

#if SD_MAC
    return image;
#elif SD_UIKIT || SD_WATCH
    if ((image.images).count > 0) {
        NSMutableArray<UIImage *> *scaledImages = [NSMutableArray array];

        for (UIImage *tempImage in image.images) {
            [scaledImages addObject:SDScaledImageForKey(key, tempImage)];
        }
        
        UIImage *animatedImage = [UIImage animatedImageWithImages:scaledImages duration:image.duration];
#ifdef SD_WEBP
        if (animatedImage) {
            SEL sd_webpLoopCount = NSSelectorFromString(@"sd_webpLoopCount");
            NSNumber *value = objc_getAssociatedObject(image, sd_webpLoopCount);
            NSInteger loopCount = value.integerValue;
            if (loopCount) {
                objc_setAssociatedObject(animatedImage, sd_webpLoopCount, @(loopCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
#endif
        return animatedImage;
    } else {
#if SD_WATCH
        if ([[WKInterfaceDevice currentDevice] respondsToSelector:@selector(screenScale)]) {
#elif SD_UIKIT
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
#endif
            CGFloat scale = [UIScreen mainScreen].scale;

            UIImage *scaledImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
            image = scaledImage;
        }
        return image;
    }
#endif
}

NSString *const SDWebImageErrorDomain = @"SDWebImageErrorDomain";
