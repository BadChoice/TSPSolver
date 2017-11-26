#import <Foundation/Foundation.h>
#import "TSPPointContract.h"
@interface TSPMultipleSolver : NSObject
+ (NSArray *)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end