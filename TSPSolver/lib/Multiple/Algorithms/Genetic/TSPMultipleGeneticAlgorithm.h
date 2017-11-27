#import <Foundation/Foundation.h>
#import "TSPPointContract.h"
#import "TSPMultipleRoute.h"
#import "TSPMultipleSolverContract.h"

@interface TSPMultipleGeneticAlgorithm : NSObject <TSPMultipleSolverContract>
- (TSPMultipleRoute* )solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end