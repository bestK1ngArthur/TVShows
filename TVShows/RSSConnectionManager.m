//
//  RSSConnectionManager.m
//  TVShows
//
//  Created by Artem Belkov on 02/03/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import "RSSConnectionManager.h"

NSString *const TVShowsNotificationConnectionDidFinishLoading = @"TVShowsNotificationConnectionDidFinishLoading";

@implementation RSSConnectionManager

+ (RSSConnectionManager *) defaultConnectionManager {
    
    static RSSConnectionManager *connectionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        connectionManager = [[RSSConnectionManager alloc] init];
        
    });
    
    return connectionManager;
}

-(void)loadFeed {
    [connection cancel];
    
    NSString *URLString = @"http://www.lostfilm.tv/rssdd.xml";
    
    if([URLString rangeOfString:@"://"].length == 0)
        URLString = [@"http://" stringByAppendingString:URLString];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    if(!URL){
        NSBeep();
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

#pragma mark Connection

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    XMLData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [XMLData appendData:data];
}

-(void)connection:(NSURLConnection *)con didFailWithError:(NSError *)err{
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Connection Error";
    notification.subtitle = err.localizedDescription;
    //[notification set_identityImage:[NSImage imageNamed:@"CF_Logo.png"]];
    [NSUserNotificationCenter.defaultUserNotificationCenter deliverNotification:notification];
    
    connection = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)con{
    connection = nil;
    
    NSError *err = nil;
    NSXMLDocument *document = [[NSXMLDocument alloc] initWithData:XMLData options:0 error:&err];
    
    if(err){
        
        NSUserNotification *notification = [[NSUserNotification alloc] init];
        notification.title = @"Connection Error";
        notification.subtitle = err.localizedDescription;
        [NSUserNotificationCenter.defaultUserNotificationCenter deliverNotification:notification];
        
        return;
    }
    
    //NSArray *titleArr = [document nodesForXPath:@"rss/channel/title" error:nil];
    
    self.feedArray = [[NSMutableArray alloc] init];
    
    NSArray *entries = [document nodesForXPath:@"rss/channel/item" error:nil];
    
    for(int i = 0; i < [entries count]; i++){
        NSXMLNode *entry = [entries objectAtIndex:i];
        
        NSString *title = [[[entry nodesForXPath:@"title" error:nil] objectAtIndex:0] stringValue];
        NSString *description = [[[entry nodesForXPath:@"description" error:nil] objectAtIndex:0] stringValue];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title",
                              description, @"description", nil];
        
        if (([title rangeOfString:@"1080p"].location == NSNotFound) && ([title rangeOfString:@"MP4"].location == NSNotFound)) {
            [self.feedArray addObject:dict];
        }
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TVShowsNotificationConnectionDidFinishLoading object:nil];
    [self launchScript];
}

#pragma mark - Scripts

- (void)launchScript {
    
    /*
    NSBundle *mainBundle=[NSBundle mainBundle];
    NSString *path=[mainBundle pathForResource:@"lostfilm-dragger" ofType:@"pl"];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: path];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError: pipe];
    
    [task setLaunchPath:@"/bin/pl"];
    
    [task launch];
    [task waitUntilExit];
    */
    
}

@end
