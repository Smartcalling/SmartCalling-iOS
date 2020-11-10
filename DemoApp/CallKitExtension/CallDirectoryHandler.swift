//
//  CallDirectoryHandler.swift
//  CallKitExtension
//
//  Created by Deniz Adalar on 10/11/2020.
//  Copyright © 2020 Incall Ltd. All rights reserved.
//

import Foundation
import SmartCalling

class CallDirectoryHandler: SmartCallingCallDirectoryHandler {
//  // Uncomment this line if you are using a custom SmartCalling server
//  override var url: URL {
//    get { URL(string: "https://portal.smartcom.net")! }
//    set {}
//  }

  override var apiKey: String? {
    get { "XXXXXX-XXXX-XXXX-XXXX-XXXXXX" }
    set {}
  }
}
