//
//  aszMathInputView.m
//  keyboard
//
//  Created by alex zaikman on 6/12/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszMathInputView.h"
#import "aszUIButton.h"


@implementation aszMathInputView


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
		[self initializeComponents];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self initializeComponents];
    }
    return self;
}

- (void)initializeComponents {
	NSArray *buttons =  [self subviews];
    for(aszUIButton *button in buttons){
        static int i;
        button.keyCode = [NSString stringWithFormat:@"%d",i];
        i++;
    }
    
}

- (IBAction)inside:(aszUIButton *)sender {
    NSString *keyCode = sender.keyCode;
    
	if (self.delegate) {
		[self.delegate insertText:keyCode];
	}
    
	[[UIDevice currentDevice] playInputClick];
}

- (BOOL) enableInputClicksWhenVisible {
    return YES;
}


@end


