#import <Foundation/Foundation.h>
#import "TSPPointContract.h"
#import "TSPMultipleRoute.h"

@interface TSPMultipleSolver : NSObject
+ (TSPMultipleRoute* )solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end