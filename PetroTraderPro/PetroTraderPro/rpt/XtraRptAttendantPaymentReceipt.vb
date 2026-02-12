Imports DevExpress.XtraReports.UI
Imports System.Drawing.Printing

Public Class XtraRptAttendantPaymentReceipt
    Private Sub XtraRptAttendantPaymentReceipt_BeforePrint(sender As Object, e As PrintEventArgs) Handles Me.BeforePrint
        If intGenReceiptType = 1 Then
            Watermark.Text = ""
        ElseIf intGenReceiptType = 2 Then
            Watermark.Text = "DUPLICATE RECEIPT"
        ElseIf intGenReceiptType = 3 Then
            Watermark.Text = "CANCELED RECEIPT"
        End If
    End Sub
End Class