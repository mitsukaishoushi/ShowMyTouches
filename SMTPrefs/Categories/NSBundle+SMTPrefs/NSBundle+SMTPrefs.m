#import <NSBundle+SMTPrefs/NSBundle+SMTPrefs.h>

@implementation NSBundle (ShowMyTouches)

+ (NSBundle *)smt_defaultBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"SMTPrefs" ofType:@"bundle"];
#if SIDELOADING
        NSString *rootlessBundlePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"SMTPrefs.bundle"];
#else
        NSString *rootlessBundlePath = jbroot(@"/Library/Application Support/SMTPrefs.bundle");
#endif

        bundle = [NSBundle bundleWithPath:tweakBundlePath ?: rootlessBundlePath];
    });

    return bundle;
}

@end