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

## Exercises
The goal of these exercises is to extract interfaces, value objects, enums and other types that can be used as generally as possible - in order to be able to reuse functionality as much as possible, and to follow the Single Resposibility Principle.

### 1. Input Form Helper

#### Exercise 1
This document assumes you will refactor the `gui/CustomerReportParam.cls` dialog.

1. Create and use a value object for the report parameters
Look at the `SetParameters` and `GetParameters` methods, and extract the input and output parameters into a value object. 
Once a value object is created, decide whether to refactor the methods to take and return the new value object, or whether to use a property. You may decide on both, in order to not break any calling code. A property is a good approach, since you will need to store the values in the dialog somewhere (due to the fact that the screen values are cleared after the dialog closes).

2. Create and use an enum for the result
While this dialog already returns an enum, it's an instance of `System.Windows.Forms.DialogResult`. This is specific to a particular client type; we want a result enum that's useable across all client- and ui-types in the application.
The enum should contain at least OK and Cancel values.
Convert the returned DialogEnum to the new enum using `GetEnum()` and perform any checks. For the `abl/d-customerreport-parameter.w` you'd return this enum (since the ABL UI doesn't return enums).

3. Extract validator logic into its own object
As a first step, change the input validation methods to consume the value object created earlier. Now you should be able to create a new class, and move the method that performs validation on that value object it it.
The dialog should now call the validator with the value object (containing screen values) and behave appropriately according to the result. The validator could return a simple logical value or something more complex. It should not throw an error, since we should not be programming logic via exception.
The validator should also be passed into the dialog (through the constructor or possibly a property).


#### Exercise 2
1. Extract an interface from the validator & implement

2. Decide whether to extract an interface from the value object & implement
It may be adequate to add a simple marker interface, or none. THe more specific an interface you are able to extract, the less type checking and casting you have to do.

3. Refactor the code that consumes the validator and value object to wokr off the interface types


### 2. Service Manager

#### Exercise 1
1. Create a Service Manager that implements the CCS IServiceManager interface
You can decide how to store the mapping from the interface to the concrete implementation. Typical choices are in config files (JSON or XML) or in code.

2. Assign it to the CCS Application static property
Create a session `start.p` that gets run first in a session. In this, assign a new instance of your Service Manager to the `Ccs.Common.Application:ServiceManager` property.

3. (OPTIONAL) Create an include to reduce boilerplate
An include that calls `getService` and casts the result to the input type will make the calling code cleaner.

4. Replace calls with getService()
Starting with those places that have parameters, variables or properties defined as interfaces, change an `NEW` statements you have with calls to the Service Manager's `getService` method.

A set of solutions can be found in https://github.com/4gl-fanatics/2019_Workshops_Solutions .
