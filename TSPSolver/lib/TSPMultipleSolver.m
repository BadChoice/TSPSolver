#import "TSPMultipleSolver.h"
#import "TSPMultipleRoute.h"
#import "TSPPointContract.h"
#import "TSPMultipleEqualAlgorithm.h"


@implementation TSPMultipleSolver

+ (TSPMultipleRoute *)solve:(int)drivers locations:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start {
    return [self solve:drivers locations:locations startingAt:start with:[TSPMultipleEqualAlgorithm new]];
}

+ (TSPMultipleRoute *)solve:(int)drivers locations:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start with:(NSObject<TSPMultipleSolverContract>*)solver{
    return [solver solve:drivers locations:locations startingAt:start];
}

@end