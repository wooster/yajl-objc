//
//  YAJLDocumentTest.m
//  YAJL
//
//  Created by Gabriel Handford on 3/1/09.
//  Copyright 2009. All rights reserved.
//

#import "NSString+SBJSON.h"

@interface YAJLDocumentTest : YAJLTestCase {}
@end

@implementation YAJLDocumentTest

- (void)test {		
	NSData *data = [self loadData:@"example"];
	
	NSError *error = nil;
	YAJLDocument *document = [[YAJLDocument alloc] initWithData:data parserOptions:0 error:&error];
	if (error) GHFail(@"Error: %@", error);
	GHTestLog(@"Root: %@", document.root);
	[document release];
}

- (void)testStreaming {
	YAJLDocument *document = [[YAJLDocument alloc] initWithParserOptions:0];

	NSError *error = nil;
	NSData *data1 = [self loadData:@"stream_array1"];
	YAJLParserStatus status1 = [document parse:data1 error:&error];
	GHAssertTrue(status1 == YAJLParserStatusInsufficientData, nil);
	if (error) GHFail(@"Error: %@", error);
	GHTestLog(@"First part: %@", document.root);
	
	NSData *data2 = [self loadData:@"stream_array2"];
	YAJLParserStatus status2 = [document parse:data2 error:&error];
	GHAssertTrue(status2 == YAJLParserStatusOK, nil);
	if (error) GHFail(@"Error: %@", error);

	GHTestLog(@"Root: %@", document.root);
	[document release];	
}

// This sample.json is too insane; Will need to revisit
- (void)_testEqualToSBJSON {
	
	NSData *data = [self loadData:@"sample"];
	GHTestLog(@"Sample data size: %d", [data length]);
	
	NSError *error = nil;

	// Build from YAJL	
	YAJLDocument *document = [[YAJLDocument alloc] initWithData:data parserOptions:0 error:&error];
	if (error) GHFail(@"Error: %@", error);
	id YAJLRoot = [document.root retain];	
	// Save
	[NSKeyedArchiver archiveRootObject:YAJLRoot toFile:[self directoryWithPath:@"yajl_sample.plist"]];
	[document release];
	
	// Build from SBJSON	
	NSString *testString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	id SBJSONRoot = [[testString JSONValue] retain];
	// Save	
	[NSKeyedArchiver archiveRootObject:SBJSONRoot toFile:[self directoryWithPath:@"sbjson_sample.plist"]];
	[testString release];

}

@end
