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

-(void)printRoute:(TSPRoute *)route{
    NSLog(@"==== Distance: %.2f Km ====", route.distance / 1000);
    NSLog(@"%@", ((TSPAddress*)route.start).name);
    [route.locations each:^(TSPAddress * address) {
        NSLog(@"%@", address.name);
    }];
    NSLog(@"%@", ((TSPAddress*)route.start).name);
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

- (void)test_exact_algorithm {
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];

    TSPRoute* route = [TSPSolver solve:locations startingAt:generalPrim with:[TSPExactAlgorithm new]];
    [self printRoute:route];
}

- (void)test_nearest_algorithm{
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];
    TSPRoute* route3 = [TSPSolver solve:locations startingAt:generalPrim with:[TSPNearestAlgorithm new]];
    [self printRoute:route3];
}

- (void)test_genetic_algorithm{
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];
    TSPRoute* route2 = [TSPSolver solve:locations startingAt:generalPrim with:[TSPGeneticAlgorithm new]];
    [self printRoute:route2];
}

- (void)testPerformanceForExactAlgorithm {
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];

    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:locations startingAt:generalPrim with:[TSPExactAlgorithm new]];
    }];
}

- (void)testPerformanceForNearestAlgorithm {
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim" latitude:41.731506 longitude:1.817945];

    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:locations startingAt:generalPrim with:[TSPNearestAlgorithm new]];
    }];
}

- (void)testPerformanceForGeneticAlgorithm {
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim" latitude:41.731506 longitude:1.817945];

    [self measureBlock:^{
        TSPRoute* route = [TSPSolver solve:locations startingAt:generalPrim with:[TSPGeneticAlgorithm new]];
    }];
}
@end
