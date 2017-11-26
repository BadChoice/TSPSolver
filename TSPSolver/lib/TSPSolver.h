#import <Foundation/Foundation.h>
#import "TSPRoute.h"
#import "TSPSolverContract.h"

@interface TSPSolver : NSObject
+ (void)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject <TSPPointContract> *)start completion:(void (^)(TSPRoute *route))completion;
+ (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start;
+ (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start with:(NSObject<TSPSolverContract>*)solver;
@end