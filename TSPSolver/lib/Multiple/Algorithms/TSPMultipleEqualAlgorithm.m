#import <Collection/NSArray+Collection.h>
#import "TSPMultipleEqualAlgorithm.h"
#import "TSPPointContract.h"
#import "TSPMultipleRoute.h"
#import "TSPSolver.h"
#import "TSPNearestAlgorithm.h"

@implementation TSPMultipleEqualAlgorithm

+ (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start{

    TSPRoute * bestRoute = [TSPSolver solve:locations startingAt:start with:[TSPNearestAlgorithm new]];

    int slice = ceil( (float)locations.count / (float)drivers) ;
    NSMutableArray * routes = [NSMutableArray new];
    for(int i = 0; i < drivers; i++){
        [routes addObject:
                [TSPRoute make:start locations:[bestRoute.locations splice:slice]]
        ];
    }
    return [[TSPMultipleRoute make:routes] optimize:[TSPNearestAlgorithm new]];
//    return [TSPMultipleRoute make:routes];
}
@end