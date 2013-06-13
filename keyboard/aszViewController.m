//
//  aszViewController.m
//  keyboard
//
//  Created by alex zaikman on 6/12/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszViewController.h"
#import "aszMathInputView.h"
#import "aszMathInputAccessoryView.h"

@interface aszViewController () <UITextInputTraits, UIKeyInput >

@property (strong, nonatomic)  UITextField *t1;
@property (weak, nonatomic) IBOutlet UITextField *t2;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

-(void)mathKeyboardNedded;
-(void)textFieldDidChange:(id)sender;

@end

@implementation aszViewController

@synthesize t1=_t1;
@synthesize t2=_t2;
@synthesize webView=_webView;

-(void)mathKeyboardNedded{
    
    
    
  
 
        self.t1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:self.t1];
        
        self.t1.inputView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputView" owner:self options:nil][0];
	    [((aszMathInputView *)self.t1.inputView) setDelegate:self];
        
        self.t1.inputAccessoryView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputAccessoryView" owner:self options:nil][0];
        [((aszMathInputAccessoryView *)self.t1.inputAccessoryView) setDelegate:self];
        
    
        [self.t1 becomeFirstResponder];
    
}



/*may be overidded but must be called at the end*/
- (BOOL)webView:(UIWebView *)webView2
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString  *requestString=[[request URL] absoluteString];
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        NSString *function = [components objectAtIndex:1];
        
        // Call the given selector
        [self performSelector:NSSelectorFromString(function)];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //////load html////
    
    // Load the html as a string from the file system
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    NSError *e;
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&e];
    
    // Tell the web view to load it
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    

    
    self.webView.delegate=self;
   // self.webView.keyboardDisplayRequiresUserAction=YES;

    


    
    
    
}


-(void)textFieldDidChange:(id)sender
{

    
    [self.webView stringByEvaluatingJavaScriptFromString:[[@"document.getElementById('math').value='" stringByAppendingString: self.t1.text ]stringByAppendingString:@"'"]];

}

- (BOOL)hasText {
	return YES;
}

- (void)insertText:(NSString *)text {
    
    if([text isEqualToString:@"regular"]){
        
        

        self.t1.inputView = nil;
        
        [self.t1 reloadInputViews];
        
        [self.t1 becomeFirstResponder];
        
        [self.t1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }else if([text isEqualToString:@"custom"]){
        
        self.t1.inputView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputView" owner:self options:nil][0];
	    [((aszMathInputView *)self.t1.inputView) setDelegate:self];
        
        [self.t1 removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self.t1 reloadInputViews];
        
         [self.t1 becomeFirstResponder];
        
    }else{
    

            self.t1.text =[self.t1.text stringByAppendingString: text];

            [self.webView stringByEvaluatingJavaScriptFromString:[[@"document.getElementById('math').value='" stringByAppendingString: self.t1.text ]stringByAppendingString:@"'"]];

        
    }
}

- (void)deleteBackward {

    
}



- (IBAction)b1:(id)sender {


    
}
- (IBAction)b2:(id)sender {
}
- (IBAction)b3:(id)sender {
}




@end
