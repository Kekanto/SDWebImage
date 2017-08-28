//
//  SDImageCache+SyncFunctions.m
//  Pods
//
//  Created by Caio Remedio on 28/08/17.
//
//

#import "SDImageCache+SyncFunctions.h"

@implementation SDImageCache (SyncFunctions)

    NSFileManager *_fileManager;

- (BOOL)diskImageExistsWithKey:(nullable NSString *)key {

    if (!_fileManager) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            _fileManager = [NSFileManager new];
        });
    }

    BOOL exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key]];

    // fallback because of https://github.com/rs/SDWebImage/pull/976 that added the extension to the disk file name
    // checking the key with and without the extension
    if (!exists) {
        exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key].stringByDeletingPathExtension];
    }

    return exists;
}

@end
