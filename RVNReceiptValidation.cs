//
//  RVNReceiptValidation.cs
//
//  Created by Paul Hart on 09/09/15.
//  Copyright (c) 2015 
//
//  This is an complementary file for the class RVNReceiptValidation.m written by Satoshi Numata
//  https://gist.github.com/sazameki/3026845
//
//  The purpose of this file is to expose the extended functions added to RVNReceiptValidation.m 
//  from RVNReceiptValidationEx.m so that they can be used in Xamarin.Mac C#.
//
//  I take no credit for the code and logic of RVNReceiptValidation.m which I have taken for
//  granted. This solution is a wrapper around the original code to get it to work with Xamarin.
//

using Foundation;

namespace PmHart83.Xamarin.Mac.Binding {
  
  [BaseType (typeof (NSObject))]
  interface RVNReceiptValidation {
    
    [Export ("setBundleID:")]
  	void SetBundleID(string bundleId);

  	[Export ("setBundleVersion:")]
  	void SetBundleVersion(string bundleVersion);

    [Export ("isValidAppStoreReceipt")]
  	bool IsValidAppStoreReceipt();

  }

}