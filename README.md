# 2019_Workshops_Before
This repo / project contains a starting point for the OOABL PUG workshop.

The premise is a UI to capture a set of parameters for a customer report, and validate the values specified. Default values may be provided as inputs.

The parameter values are returned to a caller , together with a code indicating success or failure of the validation.


## ABL UI Dialog
The dialog box `abl/d-customerreport-parameter.w` is used to create/input and validate parameters for a customer report using ABL GUI.

To run this dialog, call `run-report.p`.

## GUI for .NET Dialog
The form `gui/CustomerReportParam.cls` is used to create/input and validate parameters for a customer report using GUI for .NET.

To run this dialog, call `run-report-net.p`.


## Inputs
The dialogs asks for a date range (from & to), a customer number range (from & to) and a output file name.

## Logic
If the initial input to-date or the to-custnum are null/unknown, then only ask for a from- value (ie range with a floor).

If the initial input from-date or the from-custnum are null/unknown, then only ask for a to- value (ie range with a ceiling).

Basic validation is also performed:
- from- values must be <= to- values
- a filename must be specified

## Outputs
In addition to the screen values, a character result is returned: one of OK or CANCEL to indicate whether the report should be printed or not.
