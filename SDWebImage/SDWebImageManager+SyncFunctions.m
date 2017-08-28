//
//  SDWebImageManager+SyncFunctions.m
//  Pods
//
//  Created by Caio Remedio on 28/08/17.
//
//

#import "SDWebImageManager+SyncFunctions.h"
#import "SDImageCache+SyncFunctions.h"

@implementation SDWebImageManager (SyncFunctions)

- (BOOL)cachedImageExistsForURL:(nullable NSURL *)url {

    // Check first for in-memory
    NSString *key = [self cacheKeyForURL:url];
    BOOL isInMemoryCache = ([self.imageCache imageFromMemoryCacheForKey:key] != nil);

    if (isInMemoryCache) {
        return YES;
    }
    return YES;
    // Check for disk image
    return [self.imageCache diskImageExistsWithKey:key];
}

@end
