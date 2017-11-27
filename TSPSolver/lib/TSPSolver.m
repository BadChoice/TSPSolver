#import "TSPSolver.h"
#import "TSPSolverContract.h"
#import "TSPExactAlgorithm.h"
#import "TSPNearestAlgorithm.h"

@implementation TSPSolver

+ (void)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start completion:(void(^)(TSPRoute*route))completion{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        TSPRoute * route = [self.class solve:locations startingAt:start];
        completion(route);
    });
}

+ (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start {
    if(locations.count == 0) return [TSPRoute make:start locations:@[]];
    if(locations.count < 10){
        return [self solve:locations startingAt:start with:[TSPExactAlgorithm new]];
    }
    return [self solve:locations startingAt:start with:[TSPNearestAlgorithm new]];
}

+ (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start with:(NSObject<TSPSolverContract>*)solver{
    return [solver solve:locations startingAt:start];
}
@end