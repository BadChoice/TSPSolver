#import <Foundation/Foundation.h>
#import "TSPPointContract.h"
#import "TSPMultipleRoute.h"

@interface TSPMultipleGeneticAlgorithm : NSObject
+ (TSPMultipleRoute* )solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end