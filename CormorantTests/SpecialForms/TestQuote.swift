//
//  TestQuote.swift
//  Cormorant
//
//  Created by Austin Zheng on 1/20/15.
//  Copyright (c) 2015 Austin Zheng. All rights reserved.
//

import Foundation
@testable import Cormorant

/// Test the 'quote' special form.
class TestQuote : InterpreterTest {

  /// quote should return the second argument unchanged.
  func testQuoteReturnsArgument() {
    expectThat("(quote 12345)", shouldEvalTo: 12345)
  }

  /// quote should return the second argument unchanged, even if it's a list.
  func testQuoteReturnsList() {
    let code = symbol("+")
    expectThat("(quote (+ 1 2))", shouldEvalTo: list(containing: .symbol(code), 1, 2))
  }

  /// An outer 'quote' should not cause any inner 'quotes' to be resolved.
  func testQuoteWithNestedQuote() {
    expectThat("(quote (1 (quote 2)))", shouldEvalTo: list(containing: 1, list(containing: QUOTE, 2)))
  }

  /// 'quote' with zero arguments should return nil.
  func testQuoteZeroArity() {
    expectThat("(quote)", shouldEvalTo: .nilValue)
  }

  /// 'quote' with more than one argument should ignore and not execute any form after the first.
  func testQuoteTwoArity() {
    expectThat("(quote 1.9999123 (.print \"hello\") 2)", shouldEvalTo: 1.9999123)
    expectOutputBuffer(toBe: "")
  }
}
