//
//  AppDelegate.swift
//  TVShows
//
//  Created by Artem Belkov on 21/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "RSSConnectionManager.h"

static NSString *const kStatusMenuTemplateNameDark = @"StatusMenuTemplateDark";
static NSString *const kStatusMenuTemplateNameLight = @"StatusMenuTemplateLight";

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.menu = self.menu;
    _statusItem.image = [NSImage imageNamed:kStatusMenuTemplateNameDark];
    [_statusItem.image setTemplate:YES];
    _statusItem.highlightMode = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuNeedsUpdate:)
                                                 name:TVShowsNotificationConnectionDidFinishLoading
                                               object:_statusItem.menu];
    
    RSSConnectionManager *connectionManager = [RSSConnectionManager defaultConnectionManager];
    [connectionManager loadFeed];
    
}

- (void)dealloc
{
    // Cleanup the system status bar menu, probably not strictly necessary at this point
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

- (void)menuNeedsUpdate:(NSMenu *)menu
{
    
    // First, clear the previous items
    for (NSMenuItem *menuItem in menu.itemArray) {
        if ([menuItem hasSubmenu] || ([menuItem.title length] > 10)) {
            // Remove all DisplayModeMenuItems and submenus above the first separator
            [menu removeItem:menuItem];
        } else if ([menuItem isSeparatorItem]) {
            // Break at the first separator; this way submenu's below the separator stay intact
            break;
        }
    }
    
    // The menu to add the display modes to, by default directly into the main menu
    NSMenu *containerMenu = menu;
        
        
    // Add the display modes to the container menu (either the main menu or a display submenu)
    for (NSDictionary *dict in [[RSSConnectionManager defaultConnectionManager] feedArray]) {

        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
            
        menuItem.title = [dict objectForKey:@"title"];
            
        [containerMenu insertItem:menuItem atIndex:0];
    }
}

@end
