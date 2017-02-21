#ifdef DEBUG
#   define NSLog(fmt, ...) HBLogDebug((@"[Goodges] " fmt), ##__VA_ARGS__)
#else
#   define NSLog(...)
#endif
