#import <Foundation/Foundation.h>
#import "TSPMultipleSolverContract.h"

@protocol TSPPointContract;
@class TSPMultipleRoute;


@interface TSPMultipleEqualAlgorithm : NSObject <TSPMultipleSolverContract>

- (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end