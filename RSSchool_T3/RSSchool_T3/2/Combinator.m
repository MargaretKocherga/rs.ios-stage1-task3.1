#import "Combinator.h"

@implementation Combinator

+ (NSUInteger)factorial:(NSUInteger)number {
    return !number ? 1 : number * [Combinator factorial:number - 1];
}

- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    
    NSUInteger m = [[array firstObject] unsignedIntegerValue];
    NSUInteger n = [[array lastObject] unsignedIntegerValue];
    
    for (NSUInteger x = 1; x < n; x++) {
        NSUInteger c = [Combinator factorial:n] / ([Combinator factorial:n - x] * [Combinator factorial:x]);
        if(c == m)
            return [NSNumber numberWithUnsignedInteger:x];
    }
    
    return nil;
}
@end
