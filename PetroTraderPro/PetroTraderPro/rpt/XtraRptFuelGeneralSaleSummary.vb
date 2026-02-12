Imports Microsoft.VisualBasic.Compatibility
Imports System.Drawing.Color
Public Class XtraRptFuelGeneralSaleSummary

    Private Sub XrLabelBalance_BeforePrint(sender As Object, e As Drawing.Printing.PrintEventArgs) Handles XrLabelBalance.BeforePrint
        If Val(VB6.Format(XrLabelBalance.text, "##0.#0")) < 0 Then XrLabelBalance.BackColor = Orange
        If Val(VB6.Format(XrLabelBalance.text, "##0.#0")) > 0 Then XrLabelBalance.BackColor = White

    End Sub

    Private Sub XrLabelBalanceTotal_BeforePrint(sender As Object, e As Drawing.Printing.PrintEventArgs) Handles XrLabelBalanceTotal.BeforePrint
        If Val(VB6.Format(XrLabelBalanceTotal.text, "##0.#0")) < 0 Then XrLabelBalanceTotal.BackColor = Orange
        If Val(VB6.Format(XrLabelBalanceTotal.text, "##0.#0")) > 0 Then XrLabelBalanceTotal.BackColor = White

    End Sub

    Private Sub XrLabelVariationCash_BeforePrint(sender As Object, e As Drawing.Printing.PrintEventArgs) Handles XrLabelVariationCash.BeforePrint
        If Val(VB6.Format(XrLabelVariationCash.text, "##0.#0")) < 0 Then XrLabelVariationCash.BackColor = Orange
        If Val(VB6.Format(XrLabelVariationCash.text, "##0.#0")) > 0 Then XrLabelVariationCash.BackColor = White

    End Sub

    Private Sub XrLabelVariationCashTotal_BeforePrint(sender As Object, e As Drawing.Printing.PrintEventArgs) Handles XrLabelVariationCashTotal.BeforePrint
        If Val(VB6.Format(XrLabelVariationCashTotal.text, "##0.#0")) < 0 Then XrLabelVariationCashTotal.BackColor = Orange
        If Val(VB6.Format(XrLabelVariationCashTotal.text, "##0.#0")) > 0 Then XrLabelVariationCashTotal.BackColor = White

    End Sub

    Private Sub XrLabelVariationLiters_BeforePrint(sender As Object, e As Drawing.Printing.PrintEventArgs) Handles XrLabelVariationLiters.BeforePrint
        If Val(VB6.Format(XrLabelVariationLiters.text, "##0.#0")) < 0 Then XrLabelVariationLiters.BackColor = Orange
        If Val(VB6.Format(XrLabelVariationLiters.text, "##0.#0")) > 0 Then XrLabelVariationLiters.BackColor = White

    End Sub

    Private Sub XrLabelVariationLitersTotal_BeforePrint(sender As Object, e As Drawing.Printing.PrintEventArgs) Handles XrLabelVariationLitersTotal.BeforePrint
        If Val(VB6.Format(XrLabelVariationLitersTotal.text, "##0.#0")) < 0 Then XrLabelVariationLitersTotal.BackColor = Orange
        If Val(VB6.Format(XrLabelVariationLitersTotal.text, "##0.#0")) > 0 Then XrLabelVariationLitersTotal.BackColor = White

    End Sub
End Class