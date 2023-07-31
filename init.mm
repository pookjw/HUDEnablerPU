#import <Foundation/Foundation.h>
#import <substrate.h>

namespace PUParallaxLayerStackViewModel {
    namespace showsDebugHUD {
        BOOL (*original)(id, SEL);
        BOOL custom(id self, SEL _cmd) {
            return YES;
        }
    }
}

__attribute__((constructor)) static void init() {
    @autoreleasepool {
        MSHookMessageEx(
            NSClassFromString(@"PUParallaxLayerStackViewModel"),
            NSSelectorFromString(@"showsDebugHUD"),
            reinterpret_cast<IMP>(PUParallaxLayerStackViewModel::showsDebugHUD::custom),
            reinterpret_cast<IMP *>(PUParallaxLayerStackViewModel::showsDebugHUD::original)
        );
    }
}
