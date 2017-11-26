#import "TSPAddress.h"

@implementation TSPAddress

+ (TSPAddress*)make:(NSString *)name latitude:(double)latitude longitude:(double)longitude {
    TSPAddress* address = [TSPAddress new];
    address.name = name;
    address.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    return address;
}
@end