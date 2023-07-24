#import <Foundation/Foundation.h>
#import <substrate.h>

namespace PUParallaxLayerStackViewModel {
    namespace showsDebugHUD {
        BOOL (*original)(id, SEL);
        BOOL custom(id self, SEL _cmd) {
            return YES;
        }
    }

    namespace setShowsDebugHUD {
        void (*original)(id, SEL, BOOL);
        void custom(id self, SEL _cmd, BOOL arg1) {
            original(self, _cmd, YES);
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

        MSHookMessageEx(
            NSClassFromString(@"PUParallaxLayerStackViewModel"),
            NSSelectorFromString(@"setShowsDebugHUD"),
            reinterpret_cast<IMP>(PUParallaxLayerStackViewModel::setShowsDebugHUD::custom),
            reinterpret_cast<IMP *>(PUParallaxLayerStackViewModel::setShowsDebugHUD::original)
        );
    }
}
