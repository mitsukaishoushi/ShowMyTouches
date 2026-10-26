#import <Foundation/Foundation.h>
#if !SIDELOADING
#import <roothide.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (ShowMyTouches)

@property (class, nonatomic, readonly) NSBundle *smt_defaultBundle;

@end

NS_ASSUME_NONNULL_END