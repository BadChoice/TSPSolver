#import <Foundation/Foundation.h>
#import "TSPPointContract.h"

@interface GAMultiplePopulation : NSObject
+ (GAMultiplePopulation *)make:(int)size drivers:(int)drivers locations:(NSArray <TSPPointContract> *)locations start:(NSObject <TSPPointContract> *)start;
@end