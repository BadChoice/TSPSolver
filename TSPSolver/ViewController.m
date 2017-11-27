//
//  ViewController.m
//  TSPSolver
//
//  Created by Jordi Puigdellívol on 25/11/17.
//  Copyright © 2017 Revo Systems. All rights reserved.
//

#import "ViewController.h"
#import "RVCollection.h"
#import "TSPAddress.h"
#import "TSPRoute.h"
#import "TSPSolver.h"
#import "TSPMultipleGeneticAlgorithm.h"
#import "TSPNearestAlgorithm.h"
#import "TSPGeneticAlgorithm.h"
#import "TSPMultipleEqualAlgorithm.h"
#import "TSPMultipleEqualDeviation.h"
#import "TSPMultipleSolver.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray * data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapview.delegate = self;
    MKPointAnnotation* pin = [self drawAddress:self.startPoint];
    [self.mapview setRegion:MKCoordinateRegionMake(pin.coordinate, MKCoordinateSpanMake(0.008, 0.008))];
    
    [self.sampleData each:^(TSPAddress* address) {
        [self drawAddress:address];
    }];
}

- (TSPAddress*)startPoint{
    return [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];
}

- (NSArray<TSPPointContract>*)sampleData{
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

    if(!data){
        data = [@[revo, ataneu, baixador, stk, joviat, globus, milcentenari, museuTecnica, domenech, santJoan ,itaca, espill, hisenda, abacus, carpa, congost, mcdonalds, pius, ausa].shuffled take:10];
    }
    return data;
}

-(MKPointAnnotation*)drawAddress:(TSPAddress*)address{
    MKPointAnnotation * pin = [MKPointAnnotation new];
    pin.title = address.name;
    pin.coordinate = address.location.coordinate;
    [self.mapview addAnnotation:pin];
    return pin;
}


- (IBAction)solve1:(id)sender {
    [self clearOverrides];
    TSPRoute* route1 = [TSPSolver solve:self.sampleData startingAt:self.startPoint with:[TSPNearestAlgorithm new]];
    TSPRoute* route2 = [TSPSolver solve:self.sampleData startingAt:self.startPoint with:[TSPGeneticAlgorithm new]];

    [self drawRoute: route1.distance < route2.distance ? route1 : route2];
}

- (IBAction)solve3:(id)sender {
    [self clearOverrides];
//    TSPMultipleRoute * multipleRoute = [TSPMultipleSolver solve:3 locations:self.sampleData startingAt:self.startPoint with:[TSPMultipleGeneticAlgorithm new]];
//    TSPMultipleRoute * multipleRoute = [TSPMultipleSolver solve:3 locations:self.sampleData startingAt:self.startPoint with:[TSPMultipleEqualAlgorithm new]];
    TSPMultipleRoute * multipleRoute = [TSPMultipleSolver solve:3 locations:self.sampleData startingAt:self.startPoint with:[TSPMultipleEqualDeviation new]];

    [multipleRoute.routes each:^(TSPRoute* route) {
        [self drawRoute:route];
    }];
}

-(void)clearOverrides{
    [self.mapview removeOverlays:self.mapview.overlays];
}

-(void)drawRoute:(TSPRoute*)route{
    
    CLLocationCoordinate2D coordinateArray[route.locations.count + 2];
    
    coordinateArray[0] = route.start.location.coordinate;
    
    for(int i = 0; i < route.locations.count; i++){
        TSPAddress* address = route.locations[i];
        coordinateArray[i + 1] = address.location.coordinate;
    }
    
    coordinateArray[route.locations.count + 1] = route.start.location.coordinate;

    
    [self.mapview addOverlay:
        [MKPolyline polylineWithCoordinates:coordinateArray count:route.locations.count + 2]
    ];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    NSArray* colors = @[UIColor.redColor, UIColor.greenColor, UIColor.orangeColor, UIColor.blueColor, UIColor.grayColor, UIColor.brownColor, /*UIColor.yellowColor, *//*UIColor.cyanColor,*/ UIColor.blackColor];
    
    if ([overlay isKindOfClass:MKPolyline.class]) {
        UIColor * color = colors.random;
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        
        renderer.fillColor   = color;
        renderer.strokeColor = color;
        renderer.lineWidth   = 3;
        return renderer;
    }
    return nil;
}


@end
