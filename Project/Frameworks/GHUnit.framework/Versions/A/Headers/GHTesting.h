//
//  GHTesting.h
//  GHUnit
//
//  Created by Gabriel Handford on 1/30/09.
//  Copyright 2008 Gabriel Handford
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

//
// Portions of this file fall under the following license, marked with:
// GTM_BEGIN : GTM_END
//
//  Copyright 2008 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

extern NSString *GHUStackTraceFromException(NSException *e);

// GTM_BEGIN
BOOL isTestFixtureOfClass(Class aClass, Class testCaseClass);
// GTM_END

/*!	
 Utility test for loading and running tests.
 @note Much of this is borrowed from GTM/UnitTesting.
 */
@interface GHTesting : NSObject { 

	NSMutableArray/* of NSString*/ *testCaseClassNames_;
	
}

/*!
 The shared testing instance.
 */
+ (GHTesting *)sharedInstance;

/*!
 Load all test classes that we can "see".
 @result Array of initialized (and autoreleased) test case classes in an autoreleased array.
 */
- (NSArray *)loadAllTestCases;

/*!
 Load tests from target.
 @result Array of id<GHTest>
 */
- (NSArray *)loadTestsFromTarget:(id)target;

/*!
 See if class is of a registered test case class.
 */
- (BOOL)isTestCaseClass:(Class)aClass;

/*!
 Register test case class.
 @param aClass
 */
- (void)registerClass:(Class)aClass;

/*!
 Register test case class by name.
 @param className Class name (via NSStringFromClass(aClass)
 */
- (void)registerClassName:(NSString *)className;

/*!
 Run test.
 Exception if set is retained and should be released by the caller.
 */
+ (BOOL)runTest:(id)target selector:(SEL)selector withObject:(id)obj exception:(NSException **)exception interval:(NSTimeInterval *)interval;

@end

@protocol GHSenTestCase 
- (void)raiseAfterFailure;
@end
