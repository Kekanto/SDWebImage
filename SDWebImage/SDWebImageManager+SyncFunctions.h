//
//  SDWebImageManager+SyncFunctions.h
//  Pods
//
//  Created by Caio Remedio on 28/08/17.
//
//

#import <SDWebImage/SDWebImage.h>

@interface SDWebImageManager (SyncFunctions)

- (BOOL)cachedImageExistsForURL:(nullable NSURL *)url;

@end
