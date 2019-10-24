&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
define input-output parameter  pCustFrom as integer no-undo.
define input-output parameter pCustTo as integer no-undo.
define input-output parameter pDateFrom as date no-undo.
define input-output parameter pDateTo as date no-undo.
define input-output parameter pOutputFile as character no-undo.
define output parameter pContinue as logical no-undo initial false.


/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi-date-from fi-date-to fi-custnum-from ~
fi-custnum-to fi-output-file btn-lookup-file Btn_OK Btn_Cancel Btn_Help 
&Scoped-Define DISPLAYED-OBJECTS fi-date-from fi-date-to fi-custnum-from ~
fi-custnum-to fi-output-file 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn-lookup-file 
     LABEL "..." 
     SIZE 4 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Help 
     LABEL "&Help" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE fi-custnum-from AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Customer from" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi-custnum-to AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Customer to" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi-date-from AS DATE FORMAT "99/99/99":U INITIAL 01/01/19 
     LABEL "Date from" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi-date-to AS DATE FORMAT "99/99/99":U INITIAL 12/31/19 
     LABEL "Date to" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi-output-file AS CHARACTER FORMAT "X(256)":U INITIAL "report.pdf" 
     LABEL "Output file" 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fi-date-from AT ROW 1.95 COL 25 COLON-ALIGNED WIDGET-ID 2
     fi-date-to AT ROW 3.14 COL 25 COLON-ALIGNED WIDGET-ID 4
     fi-custnum-from AT ROW 4.81 COL 25 COLON-ALIGNED WIDGET-ID 6
     fi-custnum-to AT ROW 6 COL 25 COLON-ALIGNED WIDGET-ID 8
     fi-output-file AT ROW 7.67 COL 25 COLON-ALIGNED WIDGET-ID 12
     btn-lookup-file AT ROW 7.67 COL 66 WIDGET-ID 14
     Btn_OK AT ROW 1.95 COL 71
     Btn_Cancel AT ROW 3.19 COL 71
     Btn_Help AT ROW 5.19 COL 71
     SPACE(2.19) SKIP(2.80)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Customer Report Parameters"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME L-To-R,COLUMNS                                            */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Customer Report Parameters */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn-lookup-file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn-lookup-file Dialog-Frame
ON CHOOSE OF btn-lookup-file IN FRAME Dialog-Frame /* ... */
DO:
    system-dialog get-file pOutputFile
        title   "Select a report file ..."
        filters "Report Files (*.pdf)"   "*.pdf"
        use-filename
        .
    fi-output-file:screen-value = pOutputFile.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Help Dialog-Frame
ON CHOOSE OF Btn_Help IN FRAME Dialog-Frame /* Help */
OR HELP OF FRAME {&FRAME-NAME}
DO: /* Call Help Function (or a simple message). */
  MESSAGE "Help for File: {&FILE-NAME}" VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
    run validate-inputs.
    
    if not pContinue then
    do:
        message 
        'Validation failure: ' return-value
        view-as alert-box error.
        
        return no-apply.
    end.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */
fi-custnum-from:screen-value = string(pCustFrom).
fi-custnum-to:screen-value = string(pCustTo). 
fi-date-from:screen-value = string(pDateFrom).
fi-date-to:screen-value = string(pDateTo).
fi-output-file:screen-value = pOutputFile.

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  run set-widget-properties.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-widget-properties Dialog-Frame
procedure set-widget-properties:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
do with frame {&FRAME-NAME}:
    fi-date-from:hidden = (pDateFrom eq ?).
    fi-date-to:hidden = (pDateTo eq ?).
    
    fi-custnum-from:hidden = (pCustFrom eq ?).
    fi-custnum-to:hidden = (pCustTo eq ?).
end.
end procedure.
    
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fi-date-from fi-date-to fi-custnum-from fi-custnum-to fi-output-file 
      WITH FRAME Dialog-Frame.
  ENABLE fi-date-from fi-date-to fi-custnum-from fi-custnum-to fi-output-file 
         btn-lookup-file Btn_OK Btn_Cancel Btn_Help 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validate-inputs Dialog-Frame 
PROCEDURE validate-inputs :
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
do with frame {&FRAME-NAME}:
    if    fi-date-from:input-value eq ?
       or (
            not fi-date-to:input-value eq ?
            and fi-date-from:input-value gt fi-date-to:input-value ) 
    then
    do:
        pContinue = no.
        return 'Bad date range'.
    end.
    
    if    fi-custnum-from:input-value eq ? 
       or fi-custnum-to:input-value eq ?
    then
    do:
        pContinue = no.
        return 'Invalid customer specified'.
    end.
    
    if fi-custnum-from:input-value gt fi-custnum-to:input-value then
    do:
        pContinue = no.
        return 'Bad customer range'.
    end.
    
    if    fi-output-file:input-value eq ?
       or fi-output-file:input-value eq ''
    then
    do:
        pContinue = no.
        return 'No output file specified'.
    end.
    
    pContinue = yes.
end.
end procedure.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

