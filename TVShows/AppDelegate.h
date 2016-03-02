//
//  AppDelegate.swift
//  TVShows
//
//  Created by Artem Belkov on 21/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

@property (assign) IBOutlet NSMenu *menu;
@property (nonatomic, strong) NSStatusItem *statusItem;

@end

