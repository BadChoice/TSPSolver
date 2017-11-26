#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TSPAddress.h"

@interface TSPRoute : NSObject

@property (strong, nonatomic) NSMutableArray<TSPPointContract>* locations;
@property(nonatomic, strong) NSObject <TSPPointContract> *start;

+ (id)make:(NSObject<TSPPointContract>*)location locations:(NSArray <TSPPointContract> *)locations;
- (double)distance;
@end