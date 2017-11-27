#import "TSPMultipleEqualDeviation.h"
#import "TSPPointContract.h"
#import "TSPMultipleRoute.h"
#import "TSPNearestAlgorithm.h"
#import "NSArray+Collection.h"
#import "TSPSolver.h"

#define VARIATIONS 25

@implementation TSPMultipleEqualDeviation

- (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start{
    TSPRoute * bestRoute = [TSPSolver solve:locations startingAt:start with:[TSPNearestAlgorithm new]];
    NSMutableArray * solutions = [NSMutableArray new];
    for(int i = 0; i < VARIATIONS; i++){
        [solutions addObject:
               [self variation:drivers route:bestRoute]
        ];
    }
    return [self best:solutions];
}

- (TSPMultipleRoute *)variation:(int)drivers route:(TSPRoute*)route{
    NSMutableArray * slices = [NSMutableArray new];
    [slices addObject:@(0)];
    for(int i = 0; i < drivers - 1; i++){
        [slices addObject: @(arc4random_uniform(route.locations.count)) ];
    }
    [slices addObject:@(route.locations.count)];
    slices = [slices sort];

    NSMutableArray *routes = [NSMutableArray new];
    NSMutableArray* bestLocationsCopy = route.locations.mutableCopy;
    for(int i = 0; i < drivers; i++){
        int slice = [slices[i + 1] intValue] - [slices[i] intValue];
        [routes addObject:
                [TSPRoute make:route.start locations:[bestLocationsCopy splice:slice]]
        ];
    }
//    return [[TSPMultipleRoute make:routes] optimize:[TSPNearestAlgorithm new]];
    return [[TSPMultipleRoute make:routes] optimize];
}

- (TSPMultipleRoute *)best:(NSArray*)routes{
    return [routes minObject:@"maxRoute"];
}
@end