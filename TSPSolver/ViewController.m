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
#import "TSPMultipleSolver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapview.delegate = self;
    MKPointAnnotation* pin = [self drawAddress:self.startPoint];
    [self.mapview setRegion:MKCoordinateRegionMake(pin.coordinate, MKCoordinateSpanMake(0.01, 0.01))];
    
    [self.sampleData each:^(TSPAddress* address) {
        [self drawAddress:address];
    }];
}

- (TSPAddress*)startPoint{
    return [TSPAddress make:@"generalPrim     " latitude:41.731506 longitude:1.817945];
}

- (NSArray<TSPPointContract>*)sampleData{
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

-(MKPointAnnotation*)drawAddress:(TSPAddress*)address{
    MKPointAnnotation * pin = [MKPointAnnotation new];
    pin.title = address.name;
    pin.coordinate = address.location.coordinate;
    [self.mapview addAnnotation:pin];
    return pin;
}


- (IBAction)solve1:(id)sender {
    TSPRoute* route = [TSPSolver solve:self.sampleData startingAt:self.startPoint];
    [self drawRoute:route];
}

- (IBAction)solve3:(id)sender {
    TSPMultipleRoute* multipleRoute = [TSPMultipleSolver solve:3 locations:self.sampleData startingAt:self.startPoint];
    [multipleRoute.routes each:^(TSPRoute* route) {
        [self drawRoute:route];
    }];
    
    
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
    
    NSArray* colors = @[
       [[UIColor redColor] colorWithAlphaComponent:0.7],
       [[UIColor greenColor] colorWithAlphaComponent:0.7],
       [[UIColor orangeColor] colorWithAlphaComponent:0.7],
       [[UIColor blueColor] colorWithAlphaComponent:0.7],
       [[UIColor grayColor] colorWithAlphaComponent:0.7],
       [[UIColor brownColor] colorWithAlphaComponent:0.7],
       [[UIColor yellowColor] colorWithAlphaComponent:0.7],
       [[UIColor cyanColor] colorWithAlphaComponent:0.7],
       [[UIColor blackColor] colorWithAlphaComponent:0.7],
       [[UIColor whiteColor] colorWithAlphaComponent:0.7],
    ];
    
    if ([overlay isKindOfClass:MKPolyline.class])
    {
        
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
