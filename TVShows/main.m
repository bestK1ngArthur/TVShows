//
//  AppDelegate.swift
//  TVShows
//
//  Created by Artem Belkov on 21/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    
    AppDelegate *delegate = [[AppDelegate alloc] init];
    [[NSApplication sharedApplication] setDelegate:delegate];
    //[NSApp run];
    
    return NSApplicationMain(argc, argv);
}
