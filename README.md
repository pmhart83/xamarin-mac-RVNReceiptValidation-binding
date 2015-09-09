# RVNReceiptValidation.m Binding for Xamarin.Mac with added functions

Written by Paul Hart on 9/9/15

The product of this makefile produces a .dll and .dylib based on the source file RVNReceiptValidation.m written by Sazameki and Satoshi Numata. I do not take any credit for the logic they have written to support the Mac App Store receipt validation. This is merly a wrapper around their source to make it usable in Xamarin.Mac. It does add 3 functions which can be used in an instance of the class "RVNReceiptValidation." Since an instance was required and their source used static functions, this solution was necessary to create a useful binding. I included their base .m file in this repository for easy of use. Check their github at https://gist.github.com/sazameki/3026845 for any updates to this source. 

## Install

* Download contents of this repository and extract to local directory
* Open a terminal and navigate to the local directory
* run 'make'
* Include the reference to './bin/RVNReceiptValidationTest.app/Contents/MonoBundle/RVNReceiptValidation.dll' in your Xamarin solution
* Include './bin/RVNReceiptValidationTest.app/Contents/MonoBundle/RVNReceiptValidation.dylib' to your Xamarin project's bundle (currently requires post build action)
* In the Main.cs file of our Xamarin.Mac project, load the dylib with ObjCRuntime.Dlfcn.dlopen (dylibPath, 0) before NSApplication.Init ();
* You should now be able to create an instance of RVNReceiptValidation in Xamarin.Mac / C#.
