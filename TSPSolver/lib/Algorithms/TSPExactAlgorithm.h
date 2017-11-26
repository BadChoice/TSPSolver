#import <Foundation/Foundation.h>
#import "TSPSolverContract.h"

@interface TSPExactAlgorithm : NSObject <TSPSolverContract>
- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject <TSPPointContract> *)start;
@end