#import <Foundation/Foundation.h>
#import "TSPSolverContract.h"

@interface TSPGeneticAlgorithm : NSObject <TSPSolverContract>
@property(nonatomic) int populationSize;
@property(nonatomic) int evolutionsLimit;
@property(nonatomic) BOOL elitism;
@property(nonatomic) int tournamentSize;
@property(nonatomic) float mutationRate;
@property(nonatomic) int evolutionImprovementThreshold;
@end