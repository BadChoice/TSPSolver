#import <Foundation/Foundation.h>
#import "TSPPointContract.h"

@interface TSPAddress : NSObject <TSPPointContract>

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) CLLocation * location;

+ (TSPAddress*)make:(NSString *)name latitude:(double)latitude longitude:(double)longitude;
@end