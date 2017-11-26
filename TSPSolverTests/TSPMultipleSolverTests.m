#import "TSPSolver.h"
#import "TSPAddress.h"
#import "NSArray+Collection.h"
#import "TSPExactAlgorithm.h"
#import "TSPNearestAlgorithm.h"
#import "TSPGeneticAlgorithm.h"
#import "TSPMultipleSolver.h"
#import <XCTest/XCTest.h>

@interface TSPMultipleSolverTests : XCTestCase

@end

@implementation TSPMultipleSolverTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
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

-(void)test_can_solve_for_multiple_drivers{
    NSArray* locations          = [self sampleData];
    TSPAddress* generalPrim     = [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];

    NSArray* routes = [TSPMultipleSolver solve:3 locations:locations startingAt:generalPrim];

}
@end
