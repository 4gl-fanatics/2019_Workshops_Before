/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : print-report.p
    Description : 
    Author(s)   : pjudge
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
define input parameter pCustFrom as integer no-undo.
define input parameter pCustTo as integer no-undo.
define input parameter pDateFrom as date no-undo.
define input parameter pDateTo as date no-undo.
define input parameter pOutputFile as character no-undo.

message 
    'Report printing to ' pOutputFile
view-as alert-box.

