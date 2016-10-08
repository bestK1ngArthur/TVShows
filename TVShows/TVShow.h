//
//  TVShow.h
//  TVShows
//
//  Created by Artem Belkov on 08/10/2016.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    TVShowQualitySD,
    TVShowQualityHD,
    TVShowQualityFullHD
    
} TVShowQuality;

@interface TVShow : NSObject

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) TVShowQuality quality;

@property (assign, nonatomic) NSUInteger season;
@property (assign, nonatomic) NSUInteger episode;

@property (strong, nonatomic) NSString *studio;

@property (strong, nonatomic) NSImage *imageLink;
@property (strong, nonatomic) NSURL *torrentLink;

+ (instancetype)showFromResponse:(NSDictionary *)response;

@end
