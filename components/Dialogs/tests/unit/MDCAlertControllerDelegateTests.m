// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MaterialDialogs.h"

#import <XCTest/XCTest.h>

@interface AlertControllerDelegate : NSObject <MDCAlertControllerDelegate>
@property(nonatomic, readonly) BOOL wasDismissCalled;
@end

@implementation AlertControllerDelegate
- (void)dialogControllerDidDismiss:(MDCAlertController *)alertController {
  _wasDismissCalled = YES;
}
@end

@interface MDCAlertControllerDelegateTests : XCTestCase
/** The @c MDCAlertController being tested. */
@property(nonatomic, nullable) MDCAlertController *alertController;

/** An @c MDCAlertControllerDelegate to verify delegate functions are called. */
@property(nonatomic, nullable) AlertControllerDelegate *alertControllerDelegate;
@end

@implementation MDCAlertControllerDelegateTests

- (void)setUp {
  [super setUp];

  self.alertController = [MDCAlertController alertControllerWithTitle:@"title" message:@"message"];
  self.alertControllerDelegate = [[AlertControllerDelegate alloc] init];
  self.alertController.delegate = self.alertControllerDelegate;
}

- (void)testDismissIsCalled {
  // When
  [self.alertController loadView];
  [self.alertController.mdc_dialogPresentationController.dialogPresentationControllerDelegate
      dialogPresentationControllerDidDismiss:self.alertController.mdc_dialogPresentationController];

  // Then
  XCTAssert(self.alertControllerDelegate.wasDismissCalled);
}

@end
