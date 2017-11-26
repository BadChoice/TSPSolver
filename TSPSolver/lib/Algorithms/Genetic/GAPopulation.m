#import "GAPopulation.h"
#import "NSArray+Collection.h"
#import "TSPRoute.h"

@implementation GAPopulation
+ (GAPopulation *)make:(int)count locations:(NSArray<TSPPointContract>*)locations start:(NSObject<TSPPointContract>*)start{
    GAPopulation * population = [GAPopulation new];
    population.tours          = [[NSMutableArray alloc] initWithCapacity:count];
    for(int i = 0; i < count; i++) {
        [population.tours addObject:[TSPRoute make:start locations:locations.shuffled] ];
    }
    return population;
}

+ (GAPopulation *)make:(int)count {
    GAPopulation * population = [GAPopulation new];
    population.tours          = [[NSMutableArray alloc] initWithCapacity:count];
    return population;
}

-(TSPRoute*)best{
    return [self.tours minObject:@"distance"];
}

@end