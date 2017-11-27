#import "TSPMultipleSolver.h"
#import "GAMultiplePopulation.h"

#define POPULATION_SIZE 50
#define EVOLUTIONS 100
#define ELITISM true
#define TOURNAMENT_SIZE 5
#define MUTATION_RATE 0.015

@implementation TSPMultipleSolver
+ (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start{
    GAMultiplePopulation *population = [GAMultiplePopulation make:POPULATION_SIZE drivers:drivers locations:locations start:start];
    for (int i = 0; i < EVOLUTIONS; i++) {
        population = [self.class evolve:population];
    }
    return population.best;
}

+ (GAMultiplePopulation*)evolve:(GAMultiplePopulation*)population{
    GAMultiplePopulation * newPopulation = [GAMultiplePopulation make:POPULATION_SIZE];
    // Keep our best individual if elitism is enabled
    int elitismOffset = 0;
    if (ELITISM) {
        newPopulation.individuals[elitismOffset] = population.best;
        elitismOffset = 1;
    }

    // Crossover population
    // Loop over the new population's size and create individuals from
    // Current population
    for (int i = elitismOffset; i < POPULATION_SIZE; i++) {
        // Select parents
        TSPMultipleRoute * parent1 = [self tournamentSelection:population];
        TSPMultipleRoute * parent2 = [self tournamentSelection:population];
        // Crossover parents
        TSPMultipleRoute *child = [self crossover:parent1 parent2:parent2];
        // Add child to new population
        newPopulation.individuals[i] = child;
    }

    // Mutate the new population a bit to add some new genetic material
    for (int i = elitismOffset; i < POPULATION_SIZE; i++) {
        [self mutate:newPopulation.individuals[i]];
    }

    return newPopulation;
}


+ (TSPMultipleRoute *)tournamentSelection:(GAMultiplePopulation *)population {
    // Create a tournament population
    GAMultiplePopulation *tournament = [GAMultiplePopulation make:TOURNAMENT_SIZE];
    // For each place in the tournament get a random candidate tour and
    // add it
    for (int i = 0; i < TOURNAMENT_SIZE; i++) {
        int randomId = arc4random_uniform(POPULATION_SIZE);
        tournament.individuals[i]  = population.individuals[randomId];
    }
    // Get the fittest tour
    return tournament.best;
}

+ (TSPMultipleRoute *)crossover:(TSPMultipleRoute *)parent1 parent2:(TSPMultipleRoute *)parent2 {
    return parent1;
}

+ (void)mutate:(TSPMultipleRoute*)individual{
    for(int routePos = 0; routePos < individual.routes.count; routePos++){
        TSPRoute* route = individual.routes[routePos];
        for(int tourPos1 = 0; tourPos1 < route.locations.count; tourPos1++) {
            // Apply mutation rate
            if (((float) arc4random() / UINT32_MAX) < MUTATION_RATE) {
                // Get a second random position in the tour
                int route2Pos = arc4random_uniform(individual.routes.count);
                TSPRoute* route2 = individual.routes[route2Pos];

                if(route2.locations.count == 0){    //When second array is empty
                    NSObject <TSPPointContract> *city1 = route.locations[tourPos1];
                    [route2.locations addObject:city1];
                    [route.locations removeObject:city1];
                    return;
                }

                int tourPos2 = arc4random_uniform(route2.locations.count);

                // Get the cities at target position in tour
                NSObject <TSPPointContract> *city1 = route.locations[tourPos1];
                NSObject <TSPPointContract> *city2 = route2.locations[tourPos2];

                // Swap them around
                route2.locations[tourPos2] = city1;
                route.locations[tourPos1] = city2;
            }
        }
    }
}
@end
