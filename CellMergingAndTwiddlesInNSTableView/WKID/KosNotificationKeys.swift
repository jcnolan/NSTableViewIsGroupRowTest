//
//  KosNotificationKeys.swift
//  WKID
//  
//  This file contains constant names used for notifications.
//
//  Created by Beckertalk67 on 11/29/16.
//  Copyright © 2016 Warnock-Becker. All rights reserved.
//

import Cocoa

// MARK: - Notifications

let kosActivateTabWithIdNotification                    = "kosActivateTabWithIdNotification"
let kosAnnotationCollectionsUpdateRequiredNotification  = "kosAnnotationCollectionsUpdateRequiredNotification"
let kosAnnotationsUpdatedNotification                   = "kosAnnotationsUpdatedNotification"
let kosDocSetUpdatedNotification                        = "kosDocSetUpdatedNotification"
let kosDocSubmissionCompleteNotification                = "kosDocSubmissionCompleteNotification"        // Indicates completion of submission of a document to the system
let kosBatchSubmissionCompleteNotification              = "kosBatchSubmissionCompleteNotification"      // Indicates completion of submission of batch of documents to the system
let kosExchangeSessionClearNewMessages                  = "kosExchangeSessionClearNewMessages"
let kosExchangeSessionListUpdated                       = "kosExchangeSessionListUpdated"
let kosExchangeSessionUpdated                           = "kosExchangeSessionUpdated"
let kosFoldersKTPUpdateRequiredNotification             = "kosFoldersKTPUpdateRequiredNotification"
let kosIconLoadCompleteUpdateRequiredNotification       = "iconLoadCompleteUpdateRequiredNotification"  // Indicates that icons are loaded and refresh is needed
let kosKatalogAutosaveChangeNotification                = "kosKatalogAutosaveChangeNotification"        // Indicates that a katalog folder needs to be opened automatically
let kosKatalogAutosavesResetNotification                = "kosKatalogAutosavesResetNotification"        // Indicates that a katalog folder needs to be opened automatically
let kosKatalogDataUpdatedNotification                   = "kosKatalogDataUpdatedNotification"
let kosNewStatusMessagesNotification                    = "kosNewStatusMessagesNotification"
let kosNotesUpdatedNotification                         = "kosNotesUpdatedNotification"
let kosNotesUpdateRequiredNotification                  = "kosNotesUpdateRequiredNotification"
let kosPDFPageViewChangedNotification                   = "kosPDFPageViewChangedNotification"
let kosPreferencesUpdatedNotification                   = "kosPreferencesUpdatedNotification"
let kosProjectsUpdateRequiredNotification               = "kosProjectsUpdateRequiredNotification"       // Project view is letting KTP know something changed
let kosProjectsKtpChangedNotification                   = "kosProjectsKtpChangedNotification"           // Project KTP is letting Project View know something changed
let kosRecentsKTPUpdateRequiredNotification             = "kosRecentsKTPUpdateRequiredNotification"
let kosRecentsDocumentUpdateFailedNotification          = "kosRecentsDocumentUpdateFailedNotification"
let kosShareListUpdatedNotification                     = "kosShareListUpdatedNotification"
let kosSearchTermsUpdatedNotification                   = "kosSearchTermsUpdatedNotification"
let kosSourceListUpdatedNotification                    = "kosSourceListUpdatedNotification"
let kosSourceUpdatedNotification                        = "kosSourceUpdatedNotification"

// Specific to invoking functions from main menu

let kosResetRepositoryRequestNotification               = "kosResetRepositoryRequestNotification"

// Associated with downloading twitter data

let kosTweetDataUpdateRequiredNotification              = "tweetDataUpdateRequiredNotification";  // All new tweets loaded (as HTML pages)
let kosTweetDocReadyUpdateRequiredNotification          = "tweetDocReadyUpdateRequiredNotification"; // Indicates that a tracked document has been successfully updated
let kosTweetImageUpdateRequiredNotification             = "tweetImageUpdateRequiredNotification"; // All associated images in tweet HTML loaded / cached

// Associated with quickFormFill

let kosFormFillIsActiveNotification                     = "kosFormFillIsActiveNotification"
let kosFormFillNewDataAvailableNotification             = "kosFormFillNewDataAvailableNotification"

// Common fonts

let font13 = NSFont(name: "Avenir", size: 13.0)!
let font14 = NSFont(name: "Avenir", size: 14.0)!
let boldFont13 = NSFont(name: "Avenir-Heavy", size: 13.0)!
let boldFont11 = NSFont(name: "Avenir-Heavy", size: 11.0)!
let boldFont14 = NSFont(name: "Avenir-Heavy", size: 14.0)!

// Other constants

let KosLinkedTermAttributeKey                           = NSAttributedString.Key(rawValue: "wkid.linkedTermAttribute")
