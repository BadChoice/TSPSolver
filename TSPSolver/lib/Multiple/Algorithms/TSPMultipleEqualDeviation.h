#import <Foundation/Foundation.h>
#import "TSPMultipleSolverContract.h"

@protocol TSPPointContract;
@class TSPMultipleRoute;

@interface TSPMultipleEqualDeviation : NSObject <TSPMultipleSolverContract>
- (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end