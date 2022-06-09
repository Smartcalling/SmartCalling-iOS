//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Deniz Adalar on 09/06/2022.
//  Copyright © 2022 Incall Ltd. All rights reserved.
//

import SmartCalling
import UserNotifications

class NotificationService: UNNotificationServiceExtension {
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    // Setup SmartCallingManager
    SmartCallingManager.shared.apiKey = "XXXXXX-XXXX-XXXX-XXXX-XXXXXX"
    SmartCallingManager.shared.url = URL(string: "https://portal-uat.smartcom.net")! // Optional
    SmartCallingManager.shared.corporateEmail = "info@smartcom.net"

    let isSmartCallingNotification = SmartCallingManager.shared.processRemoteNotification(userInfo: request.content.userInfo) { _ in
      // Call content handler to present the original notification
      contentHandler(request.content)
    }

    if !isSmartCallingNotification { // Not a SmartCalling notification, check for potential other types.
      contentHandler(request.content)
    }
  }
}
