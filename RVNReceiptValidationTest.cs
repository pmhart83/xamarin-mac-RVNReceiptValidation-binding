//
//  RVNReceiptValidationTest.cs
//
//  Created by Paul Hart on 09/09/15.
//  Copyright (c) 2015 
//
//  This is an complementary file for the class RVNReceiptValidation.m written by Satoshi Numata
//  https://gist.github.com/sazameki/3026845
//
//  The purpose of this file is to test the C# Xamarin.Mac binding created by the makefile. If 
//  the makefile is successful, this code will execute and give you feedback in the terminal
//  as a last and final step of the compilation. 
//
//  I take no credit for the code and logic of RVNReceiptValidation.m which I have taken for
//  granted. This solution is a wrapper around the original code to get it to work with Xamarin.
//

using System;
using System.Reflection;
using System.IO;
using AppKit;
using Security;
using Foundation;

namespace PmHart83.Xamarin.Mac.Binding
{
	static class MainClass
	{

		// http://stackoverflow.com/questions/52797/how-do-i-get-the-path-of-the-assembly-the-code-is-in
		public static string GetCurrentExecutingDirectory()
		{
			string filePath = new Uri(Assembly.GetExecutingAssembly().CodeBase).LocalPath;
			return Path.GetDirectoryName(filePath);
		}

		static void Main (string[] args)
		{
			
			string path = GetCurrentExecutingDirectory () + "/RVNReceiptValidation.dylib";
			Console.WriteLine("ObjCRuntime.Dlfcn.dlopen ({0})", path);
			var v = ObjCRuntime.Dlfcn.dlopen (path, 0);

			NSApplication.Init ();

			RVNReceiptValidation c = new RVNReceiptValidation ();
			c.SetBundleID("com.pmhart83.mac.appname");
			c.SetBundleVersion("2.0");
			
			if(c.IsValidAppStoreReceipt()) {

				Console.WriteLine("Success: Valid Receipt");

			}else {

				Console.WriteLine("Error: Invalid Receipt");
			
			}

		}

	}
}
