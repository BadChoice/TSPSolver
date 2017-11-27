#import <Collection/NSArray+Collection.h>
#import "GAMultiplePopulation.h"
#import "TSPMultipleRoute.h"

@implementation GAMultiplePopulation

+ (GAMultiplePopulation *)make:(int)size drivers:(int)drivers locations:(NSArray <TSPPointContract> *)locations start:(NSObject <TSPPointContract> *)start {
    GAMultiplePopulation * population = [GAMultiplePopulation new];
    population.individuals            = [[NSMutableArray alloc] initWithCapacity:size];
    for(int i = 0; i < size; i++) {
        [population.individuals addObject:
            [self.class generateRandomIndividual:drivers start:start locations:locations]
        ];
    }
    return population;
}

+ (TSPMultipleRoute*)generateRandomIndividual:(int)drivers start:(NSObject <TSPPointContract> *)start locations:(NSArray <TSPPointContract> *)locations{
    NSMutableArray *routes = [NSMutableArray new];
    NSMutableArray *theLocations = locations.mutableCopy;
    for(int i = 0; i < drivers - 1; i++){
        int randomPosition = arc4random_uniform(locations.count);
        [routes addObject:[TSPRoute make:start locations:[theLocations splice:randomPosition]]];
    }
    [routes addObject:[TSPRoute make:start locations:theLocations]];

    int c = [routes flatten:@"locations"].distinct.count;
    if( c != 8){

    }

    return [TSPMultipleRoute make:routes.shuffled];
}

+ (GAMultiplePopulation *)make:(int)size{
    GAMultiplePopulation * population = [GAMultiplePopulation new];
    population.individuals    = [[NSMutableArray alloc] initWithCapacity:size];
    return population;
}
- (TSPMultipleRoute*)best{
    return [self.individuals minObject:@"maxRoute"];
}
@end