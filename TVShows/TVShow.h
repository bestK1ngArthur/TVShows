//
//  TVShow.h
//  TVShows
//
//  Created by Artem Belkov on 08/10/2016.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVShow : NSObject

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSUInteger season;
@property (assign, nonatomic) NSUInteger episode;

@property (strong, nonatomic) NSString *studio;

@property (strong, nonatomic) NSImage *imageLink;
@property (strong, nonatomic) NSURL *torrentLink;

@end
