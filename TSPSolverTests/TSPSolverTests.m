#import "TSPSolver.h"
#import "TSPAddress.h"
#import "NSArray+Collection.h"
#import "TSPExactAlgorithm.h"
#import "TSPNearestAlgorithm.h"
#import "TSPGeneticAlgorithm.h"
#import <XCTest/XCTest.h>

@interface TSPSolverTests : XCTestCase

@end

@implementation TSPSolverTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//==========================================
// HELPERS
//==========================================
-(void)printRoute:(TSPRoute *)route{
    NSLog(@"==== Distance: %.2f Km ====", route.distance / 1000);
    NSLog(@"%@", ((TSPAddress*)route.start).name);
    [route.locations each:^(TSPAddress * address) {
        NSLog(@"%@", address.name);
    }];
    NSLog(@"%@", ((TSPAddress*)route.start).name);
}

- (TSPAddress *)startLocation{
    return [TSPAddress make:@"generalPrim" latitude:41.731506 longitude:1.817945];
}

- (NSArray*)sampleData{
    TSPAddress* revo            = [TSPAddress make:@"revo            " latitude:41.7221616 longitude:1.8161533];
    TSPAddress* joviat          = [TSPAddress make:@"joviat          " latitude:41.7217212 longitude:1.8159709];
    TSPAddress* globus          = [TSPAddress make:@"globus          " latitude:41.7256689 longitude:1.8149516];
    TSPAddress* milcentenari    = [TSPAddress make:@"milcentenari    " latitude:41.7241235 longitude:1.8239209];
    TSPAddress* museuTecnica    = [TSPAddress make:@"museuTecnica    " latitude:41.7328351 longitude:1.8303368];
    TSPAddress* ataneu          = [TSPAddress make:@"ataneu          " latitude:41.7354211 longitude:1.8286953];
    TSPAddress* baixador        = [TSPAddress make:@"baixador        " latitude:41.7309856 longitude:1.8258092];
    TSPAddress* stk             = [TSPAddress make:@"stk             " latitude:41.731474 longitude:1.8220863];
    return @[revo, ataneu, baixador, stk, joviat, globus, milcentenari, museuTecnica];
}

-(NSArray*)fullSampleData{
    TSPAddress* revo            = [TSPAddress make:@"revo" latitude:41.7221616 longitude:1.8161533];
    TSPAddress* joviat          = [TSPAddress make:@"joviat" latitude:41.7217212 longitude:1.8159709];
    TSPAddress* globus          = [TSPAddress make:@"globus" latitude:41.7256689 longitude:1.8149516];
    TSPAddress* milcentenari    = [TSPAddress make:@"milcentenari" latitude:41.7241235 longitude:1.8239209];
    TSPAddress* museuTecnica    = [TSPAddress make:@"museuTecnica" latitude:41.7328351 longitude:1.8303368];
    TSPAddress* ataneu          = [TSPAddress make:@"ataneu" latitude:41.7354211 longitude:1.8286953];
    TSPAddress* baixador        = [TSPAddress make:@"baixador" latitude:41.7309856 longitude:1.8258092];
    TSPAddress* stk             = [TSPAddress make:@"stk" latitude:41.731474 longitude:1.8220863];
    TSPAddress* domenech        = [TSPAddress make:@"domenech" latitude:41.718704 longitude:1.8423813];
    TSPAddress* santJoan        = [TSPAddress make:@"santJoan" latitude:41.720738 longitude:1.8359547];
    TSPAddress* itaca           = [TSPAddress make:@"itaca" latitude:41.7239492 longitude:1.8353217];
    TSPAddress* espill          = [TSPAddress make:@"espill" latitude:41.7325311 longitude:1.8409785];
    TSPAddress* hisenda         = [TSPAddress make:@"hisenda" latitude:41.7291923 longitude:1.8229755];
    TSPAddress* abacus          = [TSPAddress make:@"abacus" latitude:41.7226515 longitude:1.820026];
    TSPAddress* carpa           = [TSPAddress make:@"carpa" latitude:41.7206878 longitude:1.816644];
    TSPAddress* congost         = [TSPAddress make:@"congost" latitude:41.7254358 longitude:1.8089567];
    TSPAddress* mcdonalds       = [TSPAddress make:@"mcdonalds" latitude:41.7386249 longitude:1.8193063];
    TSPAddress* pius            = [TSPAddress make:@"pius" latitude:41.7408343 longitude:1.8338648];
    TSPAddress* ausa            = [TSPAddress make:@"ausa" latitude:41.7383325 longitude:1.8459353];

    return @[revo, ataneu, baixador, stk, joviat, globus, milcentenari, museuTecnica, domenech, santJoan ,itaca, espill, hisenda, abacus, carpa, congost, mcdonalds, pius, ausa];
}

//==========================================
// PERFORMANCE
//==========================================
- (void)test_exact_algorithm {
    TSPRoute* route = [TSPSolver solve:self.sampleData startingAt:self.startLocation with:[TSPExactAlgorithm new]];
    [self printRoute:route];
}

- (void)test_nearest_algorithm{
    TSPRoute* route3 = [TSPSolver solve:self.sampleData startingAt:self.startLocation with:[TSPNearestAlgorithm new]];
    [self printRoute:route3];
}

- (void)test_genetic_algorithm{
    TSPRoute* route2 = [TSPSolver solve:self.sampleData startingAt:self.startLocation with:[TSPGeneticAlgorithm new]];
    [self printRoute:route2];
}

//==========================================
// PERFORMANCE
//==========================================
- (void)test_performance_for_exact_algorithm {
    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:self.sampleData startingAt:self.startLocation with:[TSPExactAlgorithm new]];
    }];
}

- (void)test_performance_for_nearest_algorithm {
    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:self.sampleData startingAt:self.startLocation with:[TSPNearestAlgorithm new]];
    }];
}

- (void)test_performance_for_genetic_algorithm {
    [self measureBlock:^{
        TSPRoute *route = [TSPSolver solve:self.sampleData startingAt:self.startLocation with:[TSPGeneticAlgorithm new]];
    }];
}

- (void)test_performance_for_exact_algorithm_with_full_data{
    //With 6 it takes 0.006 as average
    //With 7 it takes 0.043 as average
    //Limit appears to be 8: 0,3 seconds as average
    //With 9, it takes 4,02 seconds as average
    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:[self.fullSampleData take:6] startingAt:self.startLocation with:[TSPExactAlgorithm new]];
    }];
}

- (void)test_performance_for_nearest_algorithm_with_full_data {
    //19 => 0.000 seconds
    //38 => 0.001 seconds
    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:[self.fullSampleData join:self.fullSampleData] startingAt:self.startLocation with:[TSPNearestAlgorithm new]];
    }];
}


- (void)test_performance_for_genetic_algorithm_with_full_data {
    //5 => 0.140 seconds
    //7 => 0.172 seconds
    //10 => 0.208 seconds
    //15 => 0.278 seconds
    //19 => 0.378 seconds
    //38 => 0.878 seconds
    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:[self.fullSampleData take:20] startingAt:self.startLocation with:[TSPGeneticAlgorithm new]];
    }];
}
@end
