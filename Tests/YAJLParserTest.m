//
//  YAJLParserTest.m
//  YAJL
//
//  Created by Gabriel Handford on 6/14/09.
//  Copyright 2009. All rights reserved.
//


@interface YAJLParserTest : YAJLTestCase {}
@end

@implementation YAJLParserTest

- (void)test {	
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:0];
	[parser parse:[self loadData:@"example"]];
	
	NSError *error = [parser parserError];
	if (error) {
		NSLog(@"Parse error:\n%@", error);
		GHFail(@"Error: %@", error);
	}
	
	[parser release];
}

- (void)testError {
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:0];
	YAJLParserStatus status = [parser parse:[self loadData:@"error"]];
	GHAssertTrue(status == YAJLParserStatusError, @"Should have error status");
	
	NSError *error = [parser parserError];
	if (error) {
		GHTestLog(@"Parse error:\n%@", error);		
	} else {
		GHFail(@"Should have error");
	}
	
	[parser release];
}

- (void)testComments {
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:YAJLParserOptionsAllowComments];
	YAJLParserStatus status = [parser parse:[self loadData:@"comments"]];
	GHAssertTrue(status == YAJLParserStatusOK, @"Should have error status");
	
	NSError *error = [parser parserError];
	if (error) {
		GHTestLog(@"Parse error:\n%@", error);		
		GHFail(@"Error: %@", error);
	}
	
	[parser release];
}

- (void)testFailOnComments {
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:0];
	YAJLParserStatus status = [parser parse:[self loadData:@"comments"]];
	GHAssertTrue(status == YAJLParserStatusError, @"Should have error status");
	
	NSError *error = [parser parserError];
	if (error) {
		GHTestLog(@"Parse error:\n%@", error);		
	} else {
		GHFail(@"Should have error");
	}

	[parser release];
}

- (void)testOverflow {
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:0];
	YAJLParserStatus status = [parser parse:[self loadData:@"overflow"]];
	GHAssertTrue(status == YAJLParserStatusError, @"Should have error status");
	
	NSError *error = [parser parserError];
	if (error) {
		GHTestLog(@"Parse error:\n%@", error);		
	} else {
		GHFail(@"Should have error");
	}
	
	[parser release];
}

- (void)testStreaming {
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:0];
	YAJLParserStatus status;
	status = [parser parse:[self loadData:@"stream1"]];
	GHAssertTrue(status == YAJLParserStatusInsufficientData, @"Should have insufficient data");

	status = [parser parse:[self loadData:@"stream2"]];
	GHAssertTrue(status == YAJLParserStatusOK, @"Should have finished");
	[parser release];
}

// TODO(gabe): Should error if you try to re-use
- (void)_testParseMoreThanOnce {
	YAJLParser *parser = [[YAJLParser alloc] initWithParserOptions:0];
	parser.delegate = self;
	YAJLParserStatus status;
	status = [parser parse:[self loadData:@"example"]];
	GHAssertTrue(status == YAJLParserStatusOK, @"Should be OK");
	status = [parser parse:[self loadData:@"example"]];
	GHAssertTrue(status == YAJLParserStatusError, @"Should error");
}

@end