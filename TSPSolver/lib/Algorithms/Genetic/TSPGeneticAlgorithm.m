#import "TSPGeneticAlgorithm.h"
#import "GAPopulation.h"
#import "RVCollection.h"

#define ELITISM true
#define POPULATION_SIZE 50
#define TOURNAMENT_SIZE 5
#define MUTATION_RATE 0.015
#define EVLOUTIONS 100

@implementation TSPGeneticAlgorithm

/*
 * Based on: http://www.theprojectspot.com/tutorial-post/applying-a-genetic-algorithm-to-the-travelling-salesman-problem/5
 */
- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject <TSPPointContract> *)start {
    GAPopulation *population = [GAPopulation make:POPULATION_SIZE locations:locations start:start];
    for (int i = 0; i < EVLOUTIONS; i++) {
        population = [self evolve:population];
    }
    return population.best;
}

-(GAPopulation *)evolve:(GAPopulation *)population{
    GAPopulation * newPopulation = [GAPopulation make:POPULATION_SIZE];
    // Keep our best individual if elitism is enabled
    int elitismOffset = 0;
    if (ELITISM) {
        newPopulation.tours[elitismOffset] = population.best;
        elitismOffset = 1;
    }

    // Crossover population
    // Loop over the new population's size and create individuals from
    // Current population
    for (int i = elitismOffset; i < POPULATION_SIZE; i++) {
        // Select parents
        TSPRoute * parent1 = [self tournamentSelection:population];
        TSPRoute * parent2 = [self tournamentSelection:population];
        // Crossover parents
        TSPRoute *child = [self crossover:parent1 parent2:parent2];
        // Add child to new population
        newPopulation.tours[i] = child;
    }

    // Mutate the new population a bit to add some new genetic material
    for (int i = elitismOffset; i < POPULATION_SIZE; i++) {
        [self mutate:newPopulation.tours[i]];
    }

    return newPopulation;
}

// Selects candidate tour for crossover
- (TSPRoute *)tournamentSelection:(GAPopulation *)population {
    // Create a tournament population
    GAPopulation *tournament = [GAPopulation make:TOURNAMENT_SIZE];
    // For each place in the tournament get a random candidate tour and
    // add it
    for (int i = 0; i < TOURNAMENT_SIZE; i++) {
        int randomId = arc4random_uniform(POPULATION_SIZE);
        tournament.tours[i]  = population.tours[randomId];
    }
    // Get the fittest tour
    return tournament.best;
}

- (TSPRoute *)crossover:(TSPRoute *)parent1 parent2:(TSPRoute *)parent2 {
    TSPRoute *child = [TSPRoute new];
    child.start = parent1.start;
    child.locations = [NSMutableArray arrayWithCapacity:parent1.locations.count];
    for(int i = 0; i< parent1.locations.count; i++){
        [child.locations addObject:[NSNull null]];
    }

    // Get start and end sub tour positions for parent1's tour
    int startPos = arc4random_uniform(parent1.locations.count);
    int endPos   = arc4random_uniform(parent1.locations.count);

    // Loop and add the sub tour from parent1 to our child
    for (int i = 0; i < parent1.locations.count; i++) {
        // If our start position is less than the end position
        if (startPos < endPos && i > startPos && i < endPos) {
            child.locations[i] = parent1.locations[i];
            //child.setCity(i, parent1.getCity(i));
        } // If our start position is larger
        else if (startPos > endPos) {
            if (!(i < startPos && i > endPos)) {
                child.locations[i] = parent1.locations[i];
            }
        }
    }

    // Loop through parent2's city tour
    for (int i = 0; i < parent2.locations.count; i++) {
        // If child doesn't have the city add it
        if (![child.locations containsObject:parent2.locations[i]]) {
            // Loop to find a spare position in the child's tour
            for (int ii = 0; ii < parent2.locations.count; ii++) {
                // Spare position found, add city
                if ( isNull(child.locations[ii]) ){
                    child.locations[ii] = parent2.locations[i];
                    break;
                }
            }
        }
    }
    return child;
}

- (void)mutate:(TSPRoute *)route {
// Loop through tour cities
    for(int tourPos1=0; tourPos1 < route.locations.count; tourPos1++){
        // Apply mutation rate
        if(((float)arc4random() / UINT32_MAX) < MUTATION_RATE){
            // Get a second random position in the tour
            int tourPos2 = arc4random_uniform(route.locations.count);

            // Get the cities at target position in tour
            NSObject<TSPPointContract>* city1 = route.locations[tourPos1];
            NSObject<TSPPointContract>*city2 = route.locations[tourPos2];

            // Swap them around
            route.locations[tourPos2] = city1;
            route.locations[tourPos1] = city2;
        }
    }
}

@end