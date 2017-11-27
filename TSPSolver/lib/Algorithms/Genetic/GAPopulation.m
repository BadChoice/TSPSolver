#import "GAPopulation.h"
#import "NSArray+Collection.h"
#import "TSPRoute.h"

@implementation GAPopulation
+ (GAPopulation *)make:(int)count locations:(NSArray<TSPPointContract>*)locations start:(NSObject<TSPPointContract>*)start{
    GAPopulation * population = [GAPopulation new];
    population.individuals          = [[NSMutableArray alloc] initWithCapacity:count];
    for(int i = 0; i < count; i++) {
        [population.individuals addObject:[TSPRoute make:start locations:locations.shuffled] ];
    }
    return population;
}

+ (GAPopulation *)make:(int)count {
    GAPopulation * population = [GAPopulation new];
    population.individuals    = [[NSMutableArray alloc] initWithCapacity:count];
    return population;
}

-(TSPRoute*)best{
    return [self.individuals minObject:@"distance"];
}

@end