
//
//  RVNReceiptValidationEx.m
//
//  Created by Paul Hart on 09/09/15.
//  Copyright (c) 2015 
//
//  This is an extended implementation file for the class RVNReceiptValidation.m written by Satoshi Numata
//  https://gist.github.com/sazameki/3026845
//
//  The purpose of this file is to utalize the code in RVNReceiptValidation.m and expose it so that
//  it can be used in a Xamarin binding. I did not change any of the .m code found in github at the 
//  date this file was created. Only added the 3 functions below for an instance that can be used in C#.
//
//  This is used in conjunction with a makefile that appends to RVNReceiptValidation.m
//
//  I take no credit for the code and logic of RVNReceiptValidation.m which I have taken for
//  granted. This solution is a wrapper around the original code to get it to work with Xamarin.
//

@implementation RVNReceiptValidation

- (void) setBundleID:(NSString *) bundleID {

    kRVNBundleID = bundleID;

}

- (void) setBundleVersion:(NSString *) bundleVersion {

    kRVNBundleVersion = bundleVersion;

}

- (bool) isValidAppStoreReceipt {
    
    bool isSuccess = YES;
    
    @try {
        
        // Check the bundle information
        RVNCheckBundleIDAndVersion();
        RVNCheckBundleSignature();
        
        // Check the receipt information
        NSData *receiptData = RVNGetReceiptData();
        NSData *receiptDataDecoded = RVNDecodeReceiptData(receiptData);
        NSDictionary *receiptInfo = RVNGetReceiptPayload(receiptDataDecoded);
        
        RVNCheckReceiptIDAndVersion(receiptInfo);
        RVNCheckReceiptHash(receiptInfo);
        
    } @catch (NSException *e) {
        
        isSuccess = NO;
        
    }
    
    return isSuccess;
    
}

@end