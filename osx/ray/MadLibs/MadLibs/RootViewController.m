//
//  RootViewController.m
//  MadLibs
//
//  Created by David on 25/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (weak) IBOutlet NSTextField *pastTenseVerbTextField;

@property (weak) IBOutlet NSComboBox *singularNounCombo;
@property (nonatomic,strong) NSArray *singularNouns;

@property (weak) IBOutlet NSPopUpButton *pluralNounPopup;
@property (nonatomic,strong) NSArray *pluralNouns;

@property (unsafe_unretained) IBOutlet NSTextView *phraseTextView;

@property (weak) IBOutlet NSTextField *amountLabel;
@property (weak) IBOutlet NSSlider *amountSlider;

@property (weak) IBOutlet NSDatePicker *datePicker;

@property (weak) IBOutlet NSMatrix *placeRadioButton;

@property (weak) IBOutlet NSButton *yellCheck;

@property (weak) IBOutlet NSTextField *resultTextField;

@property (weak) IBOutlet NSImageView *imageView;
@end

@implementation RootViewController

- (IBAction)sliderChanged:(id)sender {
    NSInteger amount = [self.amountSlider integerValue];
    NSString *amountString = [NSString stringWithFormat:@"Amount [%ld]", amount];
    [self.amountLabel setStringValue:amountString];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)goButtonClick:(id)sender {
    NSLog(@"Go! Button clicked");
    
    NSString *pastTenseVerb = [self.pastTenseVerbTextField stringValue];
    
    NSString *singularNoun = [self.singularNounCombo stringValue];
    
    NSString *placeString;
    NSInteger row = [self.placeRadioButton selectedRow];
    if (row == 0)
        placeString = @"WWDC";
    else if (row == 1)
        placeString = @"360iDev";
    
    NSInteger amount = [self.amountSlider integerValue];
    
    NSString *pluralNoun = nil;
    NSInteger selectedIndex = [self.pluralNounPopup indexOfSelectedItem];
    pluralNoun = self.pluralNouns[selectedIndex];
    
    NSString *phrase = [self.phraseTextView string];
    
    NSString *date = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    date = [dateFormatter stringFromDate:[self.datePicker dateValue]];
    
    NSString *voice = @"said";
    if (self.yellCheck.state == NSOnState)
        voice = @"yelled";
    
    NSString *results = [NSString stringWithFormat:
                         @"On %@, at %@ a %@ %@ %@ %@ and %@, %@!",
                         date,
                         placeString,
                         singularNoun,
                         pastTenseVerb,
                         @(amount),
                         pluralNoun,
                         voice,
                         phrase];
    
    [self.resultTextField setStringValue:results];
    self.imageView.image = [NSImage imageNamed:@"face.png"];
}

- (void)awakeFromNib
{
    NSLog(@"View controller instance with view: %@", self.view);
    
    [self.pastTenseVerbTextField setStringValue:@"ate"];

    // Setup the combo box with singular nouns
    self.singularNouns = @[@"dog", @"muppet", @"ninja", @"fat dude"];
    [self.singularNounCombo addItemsWithObjectValues:self.singularNouns];
    [self.singularNounCombo selectItemAtIndex:2];
    
    // Setup PopupCombo
    self.pluralNouns = @[@"tacos", @"rainbows", @"iPhones", @"gold coins"];
    [self.pluralNounPopup removeAllItems];
    [self.pluralNounPopup addItemsWithTitles:self.pluralNouns];
    [self.pluralNounPopup selectItemAtIndex:0];
    
    [self.phraseTextView setString:@"Me coding Mac Apps!"];
    
    [self sliderChanged:self];
    
    [self.datePicker setDateValue:[NSDate date]];
    
    [self.placeRadioButton selectCellAtRow:1 column:0];
    
    self.yellCheck.state = NSOffState;
}

@end
