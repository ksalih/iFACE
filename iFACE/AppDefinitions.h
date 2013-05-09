//
//  AppDefinitions.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 11/16/12.
//  Copyright (c) 2012 Deloitte
//  All rights reserved.
//

#ifndef FieldOps_Mobile_AppDefinitions_h
#define FieldOps_Mobile_AppDefinitions_h
//segues
#define SETTINGS_SEGUE @"settingsSegue"
#define SETTINGS_WIZARD_SEGUE @"settingsWizardSegue"
#define REGISTRATION_KEY_SEGUE @"registrationKeySegue"
#define SETTINGS_WIZARD_FINISH @"finishWizardSegue"
#define SETTINGS_WIZARD_START @"wizardStartSegue"
#define SETTINGS_WIZARD_DISCLAIMER @"disclaimerSegue"
#define LOGIN_SEGUE @"loginSegue"
#define MASTER_VC_SEGUE @"masterVCSegue"
#define INBOX_SEGUE @"inboxSegue"
#define NEWCOMPANY_SEGUE @"newCompanySegue"
#define EDITCOMPANY_SEGUE @"editCompanySegue"
#define NEWITINERARY_SEGUE @"newItinerarySegue"
#define EXHIBITS_SEGUE @"exhibitsSegue"
#define EDIT_PDF_SEGUE @"editPDFSegue"
#define MAP_SEGUE @"mapSegue"
#define ADD_NEW_EXHIBIT_SEGUE @"addNewExhibitSegue"
#define EDIT_COMPANIES_LIST @"editCompaniesListSegue"
#define SHARED_DOCUMENTS_LIST_SEGUE @"sharedDocumentsListSegue"
#define DEFAULT_DOCUMENTS_LIST_SEGUE @"defaultDocumentsListSegue"
#define EDIT_PICTURE_EXIBIT_SEGUE @"editPictureExhibitSegue"
//storyboards
#define MAIN_STORYBOARD @"mainStoryBoard"

//database
#define USERS_TABLE @"DPerson"
#define CIO_TABLE @"DCIO"
#define ACTIVITY_TABLE @"DActivity"
#define PPDASSOC_TABLE @"PPDAssoc"
#define PPDCIOASSOC_TABLE @"PPDCIOAssoc"
#define MAILBOX_INBOX_TABLE @"Inbox"
#define MAILBOX_OUTBOX_TABLE @"Outbox"
#define MAILBOX_SENT_TABLE @"Sent"
#define MAILBOX_TRASH_TABLE @"Trash"

#define ITINERARY_TABLE @"Itenerary"
//Company info
#define COMPANY_TABLE @"Company"
#define COMPANY_TABLE_DEFAULT_SORT @"updatedAt"
#define COMPANY_TABLE_DEFAULT_CACHE @"CompanyCache"
#define COMPANY_TABLE_ITINERARY_PREDICATE @"itineraryInfo == %@"
#define EXHIBIT_TABLE_COMPANY_PREDICATE @"companyInfo == %@"
#define EXHIBIT_ITEM_TABLE_EXHIBIT_PREDICATE @"exhibitInfo == %@"
#define EXHIBIT_TABLE_DEFAULT_SORT @"number"
#define EXHIBIT_ITEM_TABLE_DEFAULT_SORT @"updatedAt"

#define EXHIBIT_TABLE @"Exhibit" 
#define PICTURES_TABLE @"Pictures" 
#define EXHIBIT_ITEM_TABLE @"ExhibitItem"
//default document names
#define DOC_EXIT_BRIEFING_NAME @"Exit Briefing"
#define DOC_EXIT_BRIEFING_TYPE @"pdf"
#define DOC_DEFAULT_TEMPLATES_TYPE @"pdf"


#define STATES_TABLE @"States"
#define COUNTRIES_TABLE @"Countries"
//dynamic Xib (NIBs)
#define BUTTON_STATUS_BAR_NIB @"JYStatusBarViewTableEditButtons"
#define COMPANY_CELL_NIB @"CompanyCell"

typedef enum {
    FONetworkTimeOut,
    FONetworkConnectionFailed,
    FOInvalidCredentials,
    FOLoginRequired
} FOApplicationErrorCodes;

typedef enum {
    ExhibitTypeExitBriefing,
    ExhibitTypeExitGenericPDF,
    ExhibitTypeMultiImage,
    ExhibitTypeOther
}FieldOpsExhibitTypes;

#define ERROR_DOMAIN_MAINAPP @"FOErrorDomain"
//Folder and documents manipulation
#define DOC_TEMPLATES_FOLDER @"Templates"

//Fetch Times
#define FETCH_TIME_15 [NSNumber numberWithInt:15]
#define FETCH_TIME_30 [NSNumber numberWithInt:30]
#define FETCH_TIME_60 [NSNumber numberWithInt:60]
#endif

