//
//  SDImageCache+SyncFunctions.h
//  Pods
//
//  Created by Caio Remedio on 28/08/17.
//
//

#import "SDImageCache.h"

@interface SDImageCache (SyncFunctions)

- (BOOL)diskImageExistsWithKey:(nullable NSString *)key;

@end
