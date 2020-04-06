#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *result = [NSMutableString new];
    if (numbers.count == 0) {
        return nil;
    }
    
    unsigned long power = numbers.count - 1;
    
    for (NSNumber *element in numbers) {
        if ([element integerValue] != 0) {
            if ([element integerValue] < 0) {
                if (power == numbers.count - 1) {
                    [result appendString:@"- "];
                }
                else {
                    [result appendString:@" - "];
                    element = [NSNumber numberWithInt:abs([element intValue])];
                }
            }
            else if (power + 1 < numbers.count) {
                [result appendString:@" + "];
            }
            if ([element integerValue] > 1) {
                [result appendFormat:@"%@", element];
            }
            if (power > 0) {
                [result appendString:@"x"];
                if (power > 1) {
                    [result appendFormat:@"^%lu", power];
                }
            }
        }
        power--;
    }
    
    return result;
}
@end
