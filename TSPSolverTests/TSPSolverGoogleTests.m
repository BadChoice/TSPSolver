#import "TSPSolver.h"
#import "TSPAddress.h"
#import "NSArray+Collection.h"
#import "TSPExactAlgorithm.h"
#import "TSPNearestAlgorithm.h"
#import "TSPGeneticAlgorithm.h"
#import <XCTest/XCTest.h>

@interface TSPSolverGoogleTests : XCTestCase

@end

@implementation TSPSolverGoogleTests

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

//https://developers.google.com/maps/documentation/javascript/directions?hl=es-419
@end
