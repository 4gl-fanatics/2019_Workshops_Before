/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : CustomerReportParam
    Description : Report param capture UI
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using Progress.Lang.AppError.
using Progress.Windows.Form.

class gui.CustomerReportParam inherits Form : 
    // use intermediary variables because after success (ie this-object:Close) the
    // widget values aren't available
    define private variable mCustFrom as integer no-undo.
    define private variable mCustTo as integer no-undo.
    define private variable mDateFrom as date no-undo.
    define private variable mDateTo as date no-undo.
    define private variable mOutputFile as character no-undo.
    
    define private variable button1 as System.Windows.Forms.Button no-undo.
    define private variable components as System.ComponentModel.IContainer no-undo.
    define private variable buttonOk as System.Windows.Forms.Button no-undo.
    define private variable buttonCancel as System.Windows.Forms.Button no-undo.
    define private variable dateFromLabel as System.Windows.Forms.Label no-undo.
    define private variable dateFrom as System.Windows.Forms.DateTimePicker no-undo.
    define private variable customerToLabel as System.Windows.Forms.Label no-undo.
    define private variable customerTo as System.Windows.Forms.MaskedTextBox no-undo.
    define private variable customerFromLabel as System.Windows.Forms.Label no-undo.
    define private variable customerFrom as System.Windows.Forms.MaskedTextBox no-undo.
    define private variable dateToLabel as System.Windows.Forms.Label no-undo.
    define private variable dateTo as System.Windows.Forms.DateTimePicker no-undo.
    define private variable outFile as System.Windows.Forms.TextBox no-undo.
    define private variable outFileLabel as System.Windows.Forms.Label no-undo.
    define private variable saveFileDialog1 as System.Windows.Forms.SaveFileDialog no-undo.
    
    constructor public CustomerReportParam( ):
    
        super().
        InitializeComponent ( ).
        catch e as Progress.Lang.Error:
            undo, throw e.
        end catch.        

    end constructor.

    destructor public CustomerReportParam( ):
        if valid-object(components) then do:
            cast(components, System.IDisposable):Dispose().
        end.
    end destructor.
    
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	method private void CustomerReportParam_Load( input sender as System.Object, input e as System.EventArgs ):
		SetWidgetProperties().
		return.
	end method.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void CustomerReportParam_Shown( input sender as System.Object, input e as System.EventArgs ):
        //SetWidgetProperties().
    end method.

    method private void ValidateInputs():
        if     not mDateFrom eq ?
           and not mDateTo eq ?
           and dateFrom:Value gt dateTo:Value 
        then
            undo, throw new AppError('Bad date range', 0).
        
        if     not mCustFrom eq ?
           and not mCustTo eq ?
           and integer(customerFrom:Text) gt integer(customerTo:Text) 
        then
            undo, throw new AppError('Bad customer range', 0).
        
        if outFile:Text eq '' then
            undo, throw new AppError('No output file specified', 0).
    end method.
    
    method private void SetWidgetProperties():
        dateFrom:Enabled = not (mDateFrom eq ?).
        dateTo:Enabled   = not (mDateTo eq ?).
        customerFrom:Enabled = not (mCustFrom eq ?).
        customerTo:Enabled   = not (mCustTo eq ?).
    end method.
    
    method public void SetParameterValues(input pCustFrom as integer,
                                          input pCustTo as integer,
                                          input pDateFrom as date,
                                          input pDateTo as date,
                                          input pOutputFile as character):
        mCustFrom = pCustFrom.
        mCustTo = pCustTo.
        mDateFrom = pDateFrom.
        mDateTo = pDateTo.
        mOutputFile = pOutputFile.
        
        if not mDateFrom eq ? then
            dateFrom:Value = mDateFrom.
        
        if not mDateTo eq ? then
            dateTo:Value   = mDateTo.
        
        customerFrom:Text = string(mCustFrom).
        customerTo:Text = string(mCustTo).
        
        outFile:Text = mOutputFile.
    end method.
    
    method public void GetParameterValues(output pCustFrom as integer,
                                          output pCustTo as integer,
                                          output pDateFrom as date,
                                          output pDateTo as date,
                                          output pOutputFile as character):
        pCustFrom   = mCustFrom.
        pCustTo     = mCustTo.
        pDateFrom   = mDateFrom.
        pDateTo     = mDateTo.
        pOutputFile = mOutputFile.
    end method.

    /*------------------------------------------------------------------------------
     Purshowpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void button1_Click( input sender as System.Object, input e as System.EventArgs ):
        wait-for saveFileDialog1:ShowDialog().
        
        return.
    end method.

    method private void okButton_Click (sender as System.Object, e as System.EventArgs):
        ValidateInputs().
        
        mCustFrom = integer(customerFrom:Text).
        mCustTo   = integer(customerTo:Text).
        mDateFrom = dateFrom:Value.
        mDateTo   = dateTo:Value.
        mOutputFile = outFile:Text.
        
        this-object:DialogResult = System.Windows.Forms.DialogResult:Ok.
        this-object:Close ().
        
        catch okErr as Progress.Lang.Error :
            message 
                okErr:GetMessage(1)
            view-as alert-box.
            
            this-object:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        end catch.
    end method.

    method private void cancelButton_Click (sender as System.Object, e as System.EventArgs):
        this-object:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        this-object:Close ( ).
    end method.
    
    method private void InitializeComponent ( ):

        /* NOTE: The following method is automatically generated.
           
           We strongly suggest that the contents of this method only be modified using the 
           Visual Designer to avoid any incompatible modifications.
           
           Modifying the contents of this method using a code editor will invalidate any support for this file. */
        
        @VisualDesigner.FormMember (NeedsInitialize="true").
        define variable resources as Progress.Util.ResourceManager no-undo.
        resources = new Progress.Util.ResourceManager("gui.CustomerReportParam").
        this-object:buttonOk = new System.Windows.Forms.Button().
        this-object:buttonCancel = new System.Windows.Forms.Button().
        this-object:dateFrom = new System.Windows.Forms.DateTimePicker().
        this-object:dateFromLabel = new System.Windows.Forms.Label().
        this-object:dateToLabel = new System.Windows.Forms.Label().
        this-object:dateTo = new System.Windows.Forms.DateTimePicker().
        this-object:customerFromLabel = new System.Windows.Forms.Label().
        this-object:customerFrom = new System.Windows.Forms.MaskedTextBox().
        this-object:customerTo = new System.Windows.Forms.MaskedTextBox().
        this-object:customerToLabel = new System.Windows.Forms.Label().
        this-object:outFileLabel = new System.Windows.Forms.Label().
        this-object:outFile = new System.Windows.Forms.TextBox().
        this-object:saveFileDialog1 = new System.Windows.Forms.SaveFileDialog().
        this-object:button1 = new System.Windows.Forms.Button().
        this-object:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        define variable nestedvar0 as System.Windows.Forms.AnchorStyles no-undo.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        this-object:buttonOk:Anchor = cast(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        this-object:buttonOk:Location = new System.Drawing.Point(202, 188).
        this-object:buttonOk:Name = "buttonOk".
        this-object:buttonOk:Size = new System.Drawing.Size(75, 23).
        this-object:buttonOk:TabIndex = 0.
        this-object:buttonOk:Text = "OK".
        this-object:buttonOk:UseCompatibleTextRendering = true.
        this-object:buttonOk:Click:Subscribe(this-object:okButton_Click).
        /*  */
        /* buttonCancel */
        /*  */
        define variable nestedvar1 as System.Windows.Forms.AnchorStyles no-undo.
        nestedvar1 = System.Windows.Forms.AnchorStyles:Bottom.
        this-object:buttonCancel:Anchor = cast(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        this-object:buttonCancel:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        this-object:buttonCancel:Location = new System.Drawing.Point(283, 188).
        this-object:buttonCancel:Name = "buttonCancel".
        this-object:buttonCancel:Size = new System.Drawing.Size(75, 23).
        this-object:buttonCancel:TabIndex = 1.
        this-object:buttonCancel:Text = "Cancel".
        this-object:buttonCancel:UseCompatibleTextRendering = true.
        this-object:buttonCancel:Click:Subscribe(this-object:cancelButton_Click).
        /*  */
        /* dateFrom */
        /*  */
        this-object:dateFrom:Format = System.Windows.Forms.DateTimePickerFormat:Short.
        this-object:dateFrom:Location = new System.Drawing.Point(158, 25).
        this-object:dateFrom:Name = "dateFrom".
        this-object:dateFrom:Size = new System.Drawing.Size(100, 20).
        this-object:dateFrom:TabIndex = 2.
        /*  */
        /* dateFromLabel */
        /*  */
        this-object:dateFromLabel:Location = new System.Drawing.Point(52, 22).
        this-object:dateFromLabel:Name = "dateFromLabel".
        this-object:dateFromLabel:Size = new System.Drawing.Size(100, 23).
        this-object:dateFromLabel:TabIndex = 3.
        this-object:dateFromLabel:Text = "Date from:".
        this-object:dateFromLabel:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        this-object:dateFromLabel:UseCompatibleTextRendering = true.
        /*  */
        /* dateToLabel */
        /*  */
        this-object:dateToLabel:Location = new System.Drawing.Point(52, 48).
        this-object:dateToLabel:Name = "dateToLabel".
        this-object:dateToLabel:Size = new System.Drawing.Size(100, 23).
        this-object:dateToLabel:TabIndex = 5.
        this-object:dateToLabel:Text = "Date to:".
        this-object:dateToLabel:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        this-object:dateToLabel:UseCompatibleTextRendering = true.
        /*  */
        /* dateTo */
        /*  */
        this-object:dateTo:Format = System.Windows.Forms.DateTimePickerFormat:Short.
        this-object:dateTo:Location = new System.Drawing.Point(158, 51).
        this-object:dateTo:Name = "dateTo".
        this-object:dateTo:Size = new System.Drawing.Size(100, 20).
        this-object:dateTo:TabIndex = 4.
        /*  */
        /* customerFromLabel */
        /*  */
        this-object:customerFromLabel:Location = new System.Drawing.Point(52, 75).
        this-object:customerFromLabel:Name = "customerFromLabel".
        this-object:customerFromLabel:Size = new System.Drawing.Size(100, 23).
        this-object:customerFromLabel:TabIndex = 7.
        this-object:customerFromLabel:Text = "Customer from:".
        this-object:customerFromLabel:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        this-object:customerFromLabel:UseCompatibleTextRendering = true.
        /*  */
        /* customerFrom */
        /*  */
        this-object:customerFrom:Location = new System.Drawing.Point(158, 78).
        this-object:customerFrom:Mask = "00000".
        this-object:customerFrom:Name = "customerFrom".
        this-object:customerFrom:Size = new System.Drawing.Size(100, 20).
        this-object:customerFrom:TabIndex = 8.
        this-object:customerFrom:ValidatingType = Progress.Util.TypeHelper:GetType("System.Int32").
        /*  */
        /* customerTo */
        /*  */
        this-object:customerTo:Location = new System.Drawing.Point(158, 104).
        this-object:customerTo:Mask = "00000".
        this-object:customerTo:Name = "customerTo".
        this-object:customerTo:Size = new System.Drawing.Size(100, 20).
        this-object:customerTo:TabIndex = 10.
        this-object:customerTo:ValidatingType = Progress.Util.TypeHelper:GetType("System.Int32").
        /*  */
        /* customerToLabel */
        /*  */
        this-object:customerToLabel:Location = new System.Drawing.Point(52, 101).
        this-object:customerToLabel:Name = "customerToLabel".
        this-object:customerToLabel:Size = new System.Drawing.Size(100, 23).
        this-object:customerToLabel:TabIndex = 9.
        this-object:customerToLabel:Text = "Customer to:".
        this-object:customerToLabel:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        this-object:customerToLabel:UseCompatibleTextRendering = true.
        /*  */
        /* outFileLabel */
        /*  */
        this-object:outFileLabel:Location = new System.Drawing.Point(52, 127).
        this-object:outFileLabel:Name = "outFileLabel".
        this-object:outFileLabel:Size = new System.Drawing.Size(100, 23).
        this-object:outFileLabel:TabIndex = 11.
        this-object:outFileLabel:Text = "Output file:".
        this-object:outFileLabel:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        this-object:outFileLabel:UseCompatibleTextRendering = true.
        /*  */
        /* outFile */
        /*  */
        this-object:outFile:Location = new System.Drawing.Point(159, 131).
        this-object:outFile:Name = "outFile".
        this-object:outFile:Size = new System.Drawing.Size(172, 20).
        this-object:outFile:TabIndex = 12.
        /*  */
        /* button1 */
        /*  */
        this-object:button1:Location = new System.Drawing.Point(331, 129).
        this-object:button1:Name = "button1".
        this-object:button1:Size = new System.Drawing.Size(27, 23).
        this-object:button1:TabIndex = 13.
        this-object:button1:Text = "...".
        this-object:button1:UseCompatibleTextRendering = true.
        this-object:button1:UseVisualStyleBackColor = true.
        this-object:button1:Click:Subscribe(this-object:button1_Click).
        /*  */
        /* CustomerReportParam */
        /*  */
        this-object:AcceptButton = this-object:buttonOk.
        this-object:CancelButton = this-object:buttonCancel.
        this-object:ClientSize = new System.Drawing.Size(369, 223).
        this-object:Controls:Add(this-object:button1).
        this-object:Controls:Add(this-object:outFile).
        this-object:Controls:Add(this-object:outFileLabel).
        this-object:Controls:Add(this-object:customerTo).
        this-object:Controls:Add(this-object:customerToLabel).
        this-object:Controls:Add(this-object:customerFrom).
        this-object:Controls:Add(this-object:customerFromLabel).
        this-object:Controls:Add(this-object:dateToLabel).
        this-object:Controls:Add(this-object:dateTo).
        this-object:Controls:Add(this-object:dateFromLabel).
        this-object:Controls:Add(this-object:dateFrom).
        this-object:Controls:Add(this-object:buttonCancel).
        this-object:Controls:Add(this-object:buttonOk).
        this-object:FormBorderStyle = System.Windows.Forms.FormBorderStyle:FixedDialog.
        this-object:Icon = cast(resources:GetObject("$this.Icon"), System.Drawing.Icon).
        this-object:MaximizeBox = false.
        this-object:MinimizeBox = false.
        this-object:Name = "CustomerReportParam".
        this-object:ShowInTaskbar = false.
        this-object:StartPosition = System.Windows.Forms.FormStartPosition:CenterParent.
        this-object:Text = "Customer Report Parameters".
        this-object:Load:Subscribe(this-object:CustomerReportParam_Load).
        this-object:Shown:Subscribe(this-object:CustomerReportParam_Shown).
        this-object:ResumeLayout(false).
        this-object:PerformLayout().
        catch e as Progress.Lang.Error:
            undo, throw e.
        end catch.
    end method. 
 
    method public void ShowModalDialog(  ):
        wait-for this-object:ShowDialog().
    end method.
end class.
