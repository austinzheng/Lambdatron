//
//  errors.swift
//  Lambdatron
//
//  Created by Austin Zheng on 12/22/14.
//  Copyright (c) 2014 Austin Zheng. All rights reserved.
//

import Foundation

/// An enum describing errors that can happen at runtime when evaluating macros, functions, or special forms.
enum EvalError : Printable {
  case ArityError
  case InvalidArgumentError
  case NotEvalableError
  case DivideByZeroError
  case BindingMismatchError
  case InvalidSymbolError
  case UnboundSymbolError
  case RecurMisuseError
  case EvaluatingMacroError
  case EvaluatingSpecialFormError
  case EvaluatingNoneError
  case NoFnAritiesError
  case MultipleVariadicAritiesError
  case MultipleFnDefinitionsPerArityError
  case FixedArityExceedsVariableArityError
  case RuntimeError(String?)

  var name : String {
    switch self {
    case ArityError: return "ArityError"
    case InvalidArgumentError: return "InvalidArgumentError"
    case NotEvalableError: return "NotEvalableError"
    case DivideByZeroError: return "DivideByZeroError"
    case BindingMismatchError: return "BindingMismatchError"
    case InvalidSymbolError: return "InvalidSymbolError"
    case UnboundSymbolError: return "UnboundSymbolError"
    case RecurMisuseError: return "RecurMisuseError"
    case EvaluatingMacroError: return "EvaluatingMacroError"
    case EvaluatingSpecialFormError: return "EvaluatingSpecialFormError"
    case EvaluatingNoneError: return "EvaluatingNoneError"
    case NoFnAritiesError: return "NoFnAritiesError"
    case MultipleVariadicAritiesError: return "MultipleVariadicAritiesError"
    case MultipleFnDefinitionsPerArityError: return "MultipleFnDefinitionsPerArityError"
    case FixedArityExceedsVariableArityError: return "FixedArityExceedsVariableArityError"
    case RuntimeError: return "RuntimeError"
    }
  }

  var description : String {
    let desc : String = {
      switch self {
      case ArityError:
        return "wrong number of arguments to macro, function, or special form"
      case InvalidArgumentError:
        return "invalid type or value for argument provided to macro, function, or special form"
      case NotEvalableError:
        return "item in function position is not something that can be evaluated"
      case DivideByZeroError:
        return "attempted to divide by zero"
      case BindingMismatchError:
        return "let or loop binding vector must have an even number of elements"
      case InvalidSymbolError:
        return "could not resolve the symbol"
      case UnboundSymbolError:
        return "symbol is unbound, and cannot be resolved"
      case RecurMisuseError:
        return "didn't use recur in loop or fn, or used it as a non-final form inside a composite form"
      case EvaluatingMacroError:
        return "can't take the value of a macro or reader macro"
      case EvaluatingSpecialFormError:
        return "can't take the value of a special form"
      case EvaluatingNoneError:
        return "can't take the value of 'None'; this is a logic error"
      case NoFnAritiesError:
        return "function or macro must be defined with at least one arity"
      case MultipleVariadicAritiesError:
        return "function or macro can only be defined with at most one variadic arity"
      case MultipleFnDefinitionsPerArityError:
        return "function or macro can only be defined with one definition per fixed arity"
      case FixedArityExceedsVariableArityError:
        return "fixed arities cannot have more params than a function or macro's variable arity"
      case let RuntimeError(e):
        return e != nil ? "\(e!)" : "(no message specified)"
      }
      }()
    return "(\(self.name)): \(desc)"
  }
}
