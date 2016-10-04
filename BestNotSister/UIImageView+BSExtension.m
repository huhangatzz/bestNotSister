//
//  UIImageView+BSExtension.m
//  BestNotSister
//
//  Created by huhang on 16/5/17.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "UIImageView+BSExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (BSExtension)

- (void)addCircleImageOfUrlstr:(NSString *)urlstr{

    UIImage *tempImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:tempImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        self.image = image ? [image circleImage] : tempImage;
        
    }];

}

@end
