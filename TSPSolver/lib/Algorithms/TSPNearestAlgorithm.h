#import <Foundation/Foundation.h>
#import "TSPSolverContract.h"

@interface TSPNearestAlgorithm : NSObject <TSPSolverContract>
- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject <TSPPointContract> *)start;
@end