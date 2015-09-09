//
//  RVNReceiptValidation.h
//
//  Created by Paul Hart on 09/09/15.
//  Copyright (c) 2015 
//
//  This is an extended header file for the class RVNReceiptValidation.m written by Satoshi Numata
//  https://gist.github.com/sazameki/3026845
//
//  The purpose of this header is to take the code from RVNReceiptValidation.m and expose it so that
//  it can be used in a Xamarin binding. I did not change any of the .m code found in github at the 
//  date this file was created. 
//
//  This is used in conjunction with a makefile that appends an @implementation of RVNReceiptValidation
//
//  I take no credit for the code and logic of RVNReceiptValidation.m which I have taken for
//  granted. This solution is a wrapper around the original code to get it to work with Xamarin.
//

#import <Cocoa/Cocoa.h>

@interface RVNReceiptValidation : NSObject

//from original code: RVNReceiptValidation.m

int RVNValidateAndRunApplication(int argc, char *argv[]);

//code from extension: RVNReceiptValidationEx.m

- (void) setBundleID:(NSString *) bundleID;
- (void) setBundleVersion:(NSString *) bundleVersion;
- (bool) isValidAppStoreReceipt;

@end