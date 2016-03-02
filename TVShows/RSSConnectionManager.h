//
//  RSSConnectionManager.h
//  TVShows
//
//  Created by Artem Belkov on 02/03/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

extern NSString *const TVShowsNotificationConnectionDidFinishLoading;

@interface RSSConnectionManager : NSObject {
    
    NSURLConnection *connection;
    NSMutableData *XMLData;
    
}

@property (strong, nonatomic) NSMutableArray *feedArray;

+ (RSSConnectionManager *) defaultConnectionManager;

-(void)loadFeed;

@end
