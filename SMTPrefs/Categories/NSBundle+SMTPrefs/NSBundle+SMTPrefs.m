#import <NSBundle+SMTPrefs/NSBundle+SMTPrefs.h>
#if SIDELOADING && __has_include("SMTEmbeddedBundle.h")
#import "SMTEmbeddedBundle.h"
#endif

@implementation NSBundle (ShowMyTouches)
+ (NSBundle *)smt_defaultBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SMTPrefs" ofType:@"bundle"];
#if SIDELOADING
#ifdef SMT_EMBEDDED_BUNDLE
        if (!bundlePath) {
            NSString *base = [NSTemporaryDirectory() stringByAppendingPathComponent:@SMT_EMBEDDED_BUNDLE_ID];
            bundlePath = [base stringByAppendingPathComponent:@"SMTPrefs.bundle"];
            NSData *archive = [[NSData alloc] initWithBase64EncodedString:@SMT_EMBEDDED_BUNDLE options:0];
            NSDictionary *files = [NSPropertyListSerialization propertyListWithData:archive options:NSPropertyListImmutable format:NULL error:NULL];
            NSFileManager *fm = [NSFileManager defaultManager];
            for (NSString *relativePath in files) {
                NSString *destination = [bundlePath stringByAppendingPathComponent:relativePath];
                [fm createDirectoryAtPath:[destination stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:NULL];
                if (![fm fileExistsAtPath:destination]) {
                    [(NSData *)files[relativePath] writeToFile:destination options:NSDataWritingAtomic error:NULL];
                }
            }
        }
#endif
        if (!bundlePath) bundlePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"SMTPrefs.bundle"];
#else
        if (!bundlePath) bundlePath = jbroot(@"/Library/Application Support/SMTPrefs.bundle");
#endif
        bundle = [NSBundle bundleWithPath:bundlePath];
    });
    return bundle;
}
@end
