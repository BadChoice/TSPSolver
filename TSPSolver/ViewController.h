//
//  ViewController.h
//  TSPSolver
//
//  Created by Jordi Puigdellívol on 25/11/17.
//  Copyright © 2017 Revo Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@end
