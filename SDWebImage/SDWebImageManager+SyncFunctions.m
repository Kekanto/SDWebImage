//
//  SDWebImageManager+SyncFunctions.m
//  Pods
//
//  Created by Caio Remedio on 28/08/17.
//
//

#import "SDWebImageManager+SyncFunctions.h"

@implementation SDWebImageManager (SyncFunctions)

- (BOOL)cachedImageExistsForURL:(nullable NSURL *)url {

    // Check first for in-memory
    NSString *key = [self cacheKeyForURL:url];
    BOOL isInMemoryCache = ([self.imageCache imageFromMemoryCacheForKey:key] != nil);

    if (isInMemoryCache) {
        return YES;
    }

    // Check for disk image
    BOOL exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key]];

    // fallback because of https://github.com/rs/SDWebImage/pull/976 that added the extension to the disk file name
    // checking the key with and without the extension
    if (!exists) {
        exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key].stringByDeletingPathExtension];
    }

    return exists;
}

@end
