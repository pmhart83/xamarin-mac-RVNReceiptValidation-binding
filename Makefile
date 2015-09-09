XM_PATH = /Library/Frameworks/Xamarin.Mac.framework/Versions/Current
NAMESPACE = PmHart83.Xamarin.Mac.Binding
BASE_FILE_NAME = RVNReceiptValidation
ARCH = x86_64

all: dylib bind	test

dylib:

	@# Create output directories
	mkdir -p bin tmp
	
	@# Combine source from RVNReceiptValidation with extension functions used in Xamarin
	cp RVNReceiptValidation.h tmp/RVNReceiptValidation.h
	cat RVNReceiptValidation.m > tmp/$(BASE_FILE_NAME).m
	cat RVNReceiptValidationEx.m >> tmp/$(BASE_FILE_NAME).m

	@# Create a dylib to test against
	clang -dynamiclib -arch $(ARCH) -std=gnu99 tmp/$(BASE_FILE_NAME).m -current_version 1.0 -compatibility_version 1.0 -fvisibility=hidden -framework Security -framework Cocoa -framework IOKit -o bin/$(BASE_FILE_NAME).dylib

bind:

	@# Create the C# Binding
	MONO_PATH=$(XM_PATH)/lib/mono/Xamarin.Mac $(XM_PATH)/bin/bmac-mobile-mono $(XM_PATH)/lib/bmac/bmac-mobile.exe -baselib:$(XM_PATH)/lib/reference/mobile/Xamarin.Mac.dll --api=$(BASE_FILE_NAME).cs -o:bin/$(BASE_FILE_NAME).dll --tmpdir=tmp --ns=$(NAMESPACE)

test:

	@# Create a simple test project. If you create a Xamarin.Mac project in XS, this will be done for you when you build
	mcs /out:bin/$(BASE_FILE_NAME)Test.exe $(BASE_FILE_NAME)Test.cs /target:exe /nostdlib /reference:$(XM_PATH)/lib/mono/Xamarin.Mac/System.dll /reference:$(XM_PATH)/lib/mono/Xamarin.Mac/System.Core.dll /reference:$(XM_PATH)/lib/mono/Xamarin.Mac/Xamarin.Mac.dll /reference:bin/$(BASE_FILE_NAME).dll /reference:$(XM_PATH)/lib/mono/Xamarin.Mac/mscorlib.dll
	$(XM_PATH)/bin/mmp /output:bin /name:RVNReceiptValidationTest /profile:Xamarin.Mac /arch:$(ARCH) /sgen /new-refcount /nolink /assembly:$(XM_PATH)/lib/mono/Xamarin.Mac/System.dll /assembly:$(XM_PATH)/lib/mono/Xamarin.Mac/System.Core.dll /assembly:$(XM_PATH)/lib/mono/Xamarin.Mac/Xamarin.Mac.dll /assembly:bin/$(BASE_FILE_NAME).dll /assembly:$(XM_PATH)/lib/mono/Xamarin.Mac/mscorlib.dll bin/$(BASE_FILE_NAME)Test.exe

	@# Copy the dylib into your bundle. This will be a post-build step in XS, unless you are referencing a system installed dylib
	cp bin/$(BASE_FILE_NAME).dylib bin/$(BASE_FILE_NAME)Test.app/Contents/MonoBundle/

	@# Show that everything is working
	./bin/$(BASE_FILE_NAME)Test.app/Contents/MacOS/$(BASE_FILE_NAME)Test

clean:

	rm -r ./bin
	rm -r ./tmp