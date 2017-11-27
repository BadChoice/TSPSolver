#import <Foundation/Foundation.h>

#import "TSPMultipleRoute.h";
#import "TSPPointContract.h";
#import "TSPMultipleSolverContract.h";

@interface TSPMultipleSolver : NSObject

+ (TSPMultipleRoute *)solve:(int)drivers locations:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start;
+ (TSPMultipleRoute *)solve:(int)drivers locations:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start with:(NSObject<TSPMultipleSolverContract>*)solver;
@end