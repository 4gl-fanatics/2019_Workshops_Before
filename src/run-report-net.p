/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : run-report-net.p
    Description : Runs the GUI for .NET dialog to capture report parameters 
    Author(s)   : pjudge
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

using gui.CustomerReportParam.
using System.Windows.Forms.DialogResult.

define variable iCustomerFrom as integer   no-undo.
define variable iCustomerTo   as integer   no-undo.
define variable dtDateFrom    as date      no-undo.
define variable dtDateTo      as date      no-undo.
define variable cOutputFile   as character no-undo.
define variable cContinue     as character no-undo.
define variable dlg as CustomerReportParam no-undo.
define variable oDialogResult as DialogResult no-undo .

/* ***************************  Main Block  *************************** */

assign dtDateFrom   = date (1, 1, year (today))
       dtDateTo     = date (12, 31, year (today))
       //dtDateTo     = ? // uncomment to disable field
       //iCustomerTo  = ? // uncomment to disable field
       iCustomerFrom = 0
       iCustomerTo   = 99
       cOutputFile  = "report.pdf" 
       .

dlg = new CustomerReportParam().

dlg:SetParameterValues(input iCustomerFrom, 
                   input iCustomerTo,
                   input dtDateFrom,
                   input dtDateTo,
                   input cOutputFile).

wait-for dlg:ShowDialog () set oDialogResult .

cContinue = string(oDialogResult).
if cContinue = "OK" then  
do:
    dlg:GetParameterValues(output iCustomerFrom, 
                           output iCustomerTo,
                           output dtDateFrom,
                           output dtDateTo,
                           output cOutputFile).
    
    run print-report.p (input iCustomerFrom, 
                        input iCustomerTo,
                        input dtDateFrom,
                        input dtDateTo,
                        input cOutputFile).
end.