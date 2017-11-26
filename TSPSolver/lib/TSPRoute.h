#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TSPAddress.h"

@interface TSPRoute : NSObject

@property (strong, nonatomic) NSMutableArray<TSPPointContract>* locations;
@property (strong, nonatomic) NSObject <TSPPointContract> *start;

+ (id)make:(NSObject<TSPPointContract>*)location locations:(NSArray <TSPPointContract> *)locations;
- (double)distance;
@end