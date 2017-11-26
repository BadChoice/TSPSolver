#import "TSPMultipleSolver.h"
#import "GAMultiplePopulation.h"

#define POPULATION_SIZE 50
#define EVLOUTIONS 100

@implementation TSPMultipleSolver
+ (NSArray *)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start{
    GAMultiplePopulation *population = [GAMultiplePopulation make:POPULATION_SIZE drivers:drivers locations:locations start:start];
    for (int i = 0; i < EVLOUTIONS; i++) {
        population = [self.class evolve:population];
    }
    return population.best;
}

+(GAMultiplePopulation*)evolve:(GAMultiplePopulation*)population{

}


@end