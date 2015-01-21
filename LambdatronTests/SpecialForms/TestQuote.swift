//
//  TestQuote.swift
//  Lambdatron
//
//  Created by Austin Zheng on 1/20/15.
//  Copyright (c) 2015 Austin Zheng. All rights reserved.
//

import Foundation

/// Test the 'quote' special form.
class TestQuote : InterpreterTest {

  override func setUp() {
    clearOutputBuffer()
    interpreter.writeOutput = writeToBuffer
  }

  override func tearDown() {
    // Reset the interpreter
    clearOutputBuffer()
    interpreter.writeOutput = print
  }

  /// quote should return the second argument unchanged.
  func testQuoteReturnsArgument() {
    expectThat("(quote 12345)", shouldEvalTo: .IntegerLiteral(12345))
  }

  /// quote should return the second argument unchanged, even if it's a list.
  func testQuoteReturnsList() {
    let code = interpreter.context.symbolForName("+")
    expectThat("(quote (+ 1 2))",
      shouldEvalTo: .ListLiteral(Cons(.Symbol(code), next:Cons(.IntegerLiteral(1), next: Cons(.IntegerLiteral(2))))))
  }

  /// An outer 'quote' should not cause any inner 'quotes' to be resolved.
  func testQuoteWithNestedQuote() {
    expectThat("(quote (1 (quote 2)))",
      shouldEvalTo: .ListLiteral(Cons(.IntegerLiteral(1),
        next: Cons(.ListLiteral(Cons(.Special(.Quote), next: Cons(.IntegerLiteral(2))))))))
  }

  /// 'quote' with zero arguments should return nil.
  func testQuoteZeroArity() {
    expectThat("(quote)", shouldEvalTo: .NilLiteral)
  }

  /// 'quote' with more than one argument should ignore and not execute any form after the first.
  func testQuoteTwoArity() {
    expectThat("(quote 1.9999123 (.print \"hello\") 2)", shouldEvalTo: .FloatLiteral(1.9999123))
    expectOutputBuffer(toBe: "")
  }
}
