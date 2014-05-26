//
//  PostCellView.h
//  NSScanner
//
//  Created by Vincent Ngo on 11/2/13.
//  Copyright (c) 2013 Raywenderlich. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PostCellView : NSTableCellView

@property (nonatomic, strong) IBOutlet NSTextField *from;
@property (nonatomic, strong) IBOutlet NSTextField *email;
@property (nonatomic, strong) IBOutlet NSTextField *subject;
@property (nonatomic, strong) IBOutlet NSTextField *date;
@property (nonatomic, strong) IBOutlet NSTextField *organization;
@property (nonatomic, strong) IBOutlet NSTextField *costRelated;
@property (nonatomic, strong) IBOutlet NSTextField *keywords;
@property (nonatomic, strong) IBOutlet NSTextField *lines;

@end
