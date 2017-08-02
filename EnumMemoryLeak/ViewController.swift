//
//  ViewController.swift
//  EnumMemoryLeak
//
//  Created by Cem Kozinoglu, Gene Goykhman on 4/22/17.
//  Copyright © 2017 Giphy. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//
//
//  Credits:
//  Jared Halpern, Jillian Fisher, Randy Shepherd
//  &&
//  https://github.com/endavid/SwiftLeaks
//  Looks like the leak referenced at SwiftLeaks fixed by Apple
//  However when you do use @objc in Swift for the Enum
//  the same issue surfaces back and here is a sample project to replicate the leak.
//
//  How to test:
//  Command+I -> Choose Leaks instrument -> Record

import UIKit

// Without @objc this enum won't leak
// however when this enum is included in a class
// which contains an array, it will leak
@objc enum leakingObjCMarkedEnum: Int {
    
    // Just some random cases.
    case apple, orange
}

// Wrapper class which contains an enum and Array
// The class needs to contain the the Array in order for
// the Enum to leak.
class WrapperClass {
  
  // Optional enums marked with @objc will leak.
  var leakyOptionalEnum: leakingObjCMarkedEnum?
  
  // Include an array to trigger this behaviour.
  // Empty arrays won't cause the leak, so lets add an arbitrary Int
  var myArray: [Int] = [80]
}

class ViewController: UIViewController {
  
  // Hang on to a reference to our Wrapper Class instance.
  var wc: WrapperClass?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Allocate an instance of our class
    // and things will start leaking at this point.
    wc = WrapperClass()
  }
}
