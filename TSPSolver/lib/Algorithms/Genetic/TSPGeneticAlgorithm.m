#import "TSPGeneticAlgorithm.h"
#import "GAPopulation.h"
#import "RVCollection.h"

@implementation TSPGeneticAlgorithm

- (instancetype)init {
    self = [super init];
    if (self) {
        self.populationSize = 50;
        self.evolutionsLimit = 2000;
        self.elitism = true;
        self.tournamentSize = 5;
        self.mutationRate = 0.015;
        self.evolutionImprovementThreshold = 100;
    }

    return self;
}

/*
 * Based on: http://www.theprojectspot.com/tutorial-post/applying-a-genetic-algorithm-to-the-travelling-salesman-problem/5
 */
- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject <TSPPointContract> *)start {
    //self.populationSize = 100;
    //self.mutationRate = 0.015;
    self.evolutionImprovementThreshold = 100;
    GAPopulation *population = [GAPopulation make:self.populationSize locations:locations start:start];
    double lastBestValue     = -1;
    int notChangedEvolutions = 0;
    for (int i = 0; i < self.evolutionsLimit; i++) {
        population = [self evolve:population];
        double bestDistance = population.best.distance;
        if(bestDistance < lastBestValue || lastBestValue == -1){
            notChangedEvolutions = 0;
            lastBestValue = bestDistance;
        }
        else{
            notChangedEvolutions++;
        }
        if(notChangedEvolutions == self.evolutionImprovementThreshold){
            //NSLog(@"Evolutions: %d, Distance %.2f Km", i, lastBestValue/1000);
            return population.best;
        }
    }
    return population.best;
}

-(GAPopulation *)evolve:(GAPopulation *)population{
    GAPopulation * newPopulation = [GAPopulation make:self.populationSize];
    // Keep our best individual if elitism is enabled
    int elitismOffset = 0;
    if (self.elitism) {
        newPopulation.individuals[elitismOffset] = population.best;
        elitismOffset = 1;
    }

    // Crossover population
    // Loop over the new population's size and create individuals from
    // Current population
    for (int i = elitismOffset; i < self.populationSize; i++) {
        // Select parents
        TSPRoute * parent1 = [self tournamentSelection:population];
        TSPRoute * parent2 = [self tournamentSelection:population];
        // Crossover parents
        TSPRoute *child = [self crossover:parent1 parent2:parent2];
        // Mutate the new population a bit to add some new genetic material
        [self mutate:child];

        // Add child to new population
        newPopulation.individuals[i] = child;
    }

    return newPopulation;
}

// Selects candidate tour for crossover
- (TSPRoute *)tournamentSelection:(GAPopulation *)population {
    // Create a tournament population
    GAPopulation *tournament = [GAPopulation make:self.tournamentSize];
    // For each place in the tournament get a random candidate tour and
    // add it
    for (int i = 0; i < self.tournamentSize; i++) {
        int randomId = arc4random_uniform(self.populationSize);
        tournament.individuals[i]  = population.individuals[randomId];
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
    for(int tourPos1=0; tourPos1 < route.locations.count; tourPos1++){
        // Apply mutation rate
        if(((float)arc4random() / UINT32_MAX) < self.mutationRate){
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