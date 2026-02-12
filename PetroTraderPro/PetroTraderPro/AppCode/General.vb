Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports System.Security.Cryptography
Imports System.IO
Imports Zenoph.Notify.Enums
Imports Zenoph.Notify.Request
Imports Zenoph.Notify.Response

Module General

    Public intUserID As Integer
    Public intUserRole As Integer
    Public PicIDnUM As Integer = 0
    Public strRec As String = ""
    Public Condb As SqlConnection
    Public objCommand As SqlCommand, objReader As SqlDataReader, objDataTable As DataTable, objDataSet As DataSet
    Public strCon As String = System.Configuration.ConfigurationManager.ConnectionStrings("PetroTraderConnectionString").ConnectionString
    Public objConnect As New SqlConnection(strCon)

    Public dsTemp As DataSet, dsCurrentDate As DataSet, dtAllYear As DataTable, dtAllGender As DataTable
    Public StrCurrentDate As String
    Public dtTemp As DataTable, dtAllCurrentYear As DataTable
    Public dateFrom As String, DateTo As String
    Public fLoad As Boolean
    Public dsNewRec As DataSet, dtSMSAccount As DataTable, dtSchoolInfo As DataTable
    Public intGenReceiptType As Integer
    Public smsErrMsg As String, mySMSApi As String, mySMSSender As String


    Public Function GenerateTransactionCode() As String
        Dim dblRandom As New Random
        Dim str = CInt(Now.Date.Day.ToString) * CInt(Now.Date.Month.ToString) + CInt(Now.Date.Year.ToString) * CInt(Now.TimeOfDay.Hours.ToString) + CInt(Now.TimeOfDay.Minutes.ToString) * CInt(Now.TimeOfDay.Seconds) + CInt(Now.TimeOfDay.Milliseconds)
        GenerateTransactionCode = (Replace(dblRandom.NextDouble(), "0.", Now.TimeOfDay.Milliseconds)).ToString & str.ToString
        Return GenerateTransactionCode

    End Function


    Public Function LoadData(ByVal StrSQL As String) As DataSet
        'Loan general Data from different Tables


        If objConnect.State = 0 Then
            Call ConnectDBase()
        End If

        objCommand = New SqlCommand
        objDataTable = New DataTable
        objDataSet = New DataSet

        objCommand.Connection = objConnect
        objCommand.CommandType = CommandType.Text

        objCommand.CommandText = StrSQL

        objReader = objCommand.ExecuteReader()
        objDataTable.Load(objReader)
        objReader.Close()

        objDataSet.Tables.Add(objDataTable)
        Return objDataSet

        objConnect.Close()

    End Function


    Public Sub ConnectDBase()
        objConnect = New SqlConnection() With {.ConnectionString = strCon}
        objConnect.Open()
    End Sub

    Public Sub ExecuteMyQuery(ByVal StrQuery As String)
        If objConnect.State = 0 Then
            Call ConnectDBase()
        End If


        objCommand = New SqlCommand() With {.Connection = objConnect, .CommandType = CommandType.Text, .CommandText = StrQuery}
        objCommand.ExecuteNonQuery()
        objConnect.Close()
    End Sub

    Public Function LoadManyDataSets(ByVal StrQuery() As String, ByVal N As Integer) As DataSet()
        'Loan general Data from different Tables


        If objConnect.State = 0 Then
            Call ConnectDBase()
        End If

        objDataTable = New DataTable
        Dim dsObj(N) As DataSet

        objCommand = New SqlCommand() With {.Connection = objConnect}


        For i = 0 To N
            objDataTable = New DataTable
            dsObj(i) = New DataSet
            objCommand.CommandType = CommandType.Text
            objCommand.CommandText = StrQuery(i)

            objReader = objCommand.ExecuteReader()
            objDataTable.Load(objReader)
            objReader.Close()
            dsObj(i).Tables.Add(objDataTable)
        Next

        Return dsObj

        objConnect.Close()

    End Function


    Public Function LoadDataTables(ByVal StrTable() As String, ByVal N As Integer, ByVal StrTableName() As String) As DataTable()
        'Load general Data from different Tables


        'If objConnect.State = 0 Then
        Call ConnectDBase()
        'End If

        objCommand = New SqlCommand
        objDataTable = New DataTable
        Dim dsObj(N) As DataTable
        objDataSet = New DataSet

        objCommand.Connection = objConnect

        For i = 0 To N
            objDataSet = New DataSet
            dsObj(i) = New DataTable
            objCommand.CommandType = CommandType.Text
            objCommand.CommandText = StrTable(i)

            objReader = objCommand.ExecuteReader()
            objDataTable = New DataTable
            objDataTable.Load(objReader)
            objReader.Close()
            objDataSet.Tables.Add(objDataTable)


            dsObj(i) = objDataSet.Tables(0)
            dsObj(i).TableName = StrTableName(i)
        Next

        Return dsObj

        objConnect.Close()

    End Function


    Public Function GetSearchString(ByVal strSearchText As String) As String
        Dim words As String() = strSearchText.Trim.Split(New Char() {" "c})
        Dim Finalstr As String = ""
        Dim N = words.Length - 1
        For I = 0 To N
            If I <> N Then
                Finalstr = String.Format("{0} CustomerName LIKE '%{1}%'  AND", Finalstr, words(I).Trim)
            Else
                Finalstr = String.Format("{0} CustomerName LIKE '%{1}%' ", Finalstr, words(I).Trim)
            End If
        Next
        GetSearchString = Finalstr
        Return (GetSearchString)

    End Function
    Public Function GetProductSearchString(ByVal strSearchText As String) As String
        Dim words As String() = strSearchText.Trim.Split(New Char() {" "c})
        Dim Finalstr As String = ""
        Dim N = words.Length - 1
        For I = 0 To N
            If I <> N Then
                Finalstr = String.Format("{0} ProductName LIKE '%{1}%'  AND", Finalstr, words(I).Trim)
            Else
                Finalstr = String.Format("{0} ProductName LIKE '%{1}%' ", Finalstr, words(I).Trim)
            End If
        Next
        GetProductSearchString = Finalstr
        Return (GetProductSearchString)

    End Function

    Public Function GetAge(ByVal strBirthDate As String)
        Dim Age As String
        If strBirthDate.Trim = "" Then Age = "" : GoTo 23
        Dim Myds As DataSet = LoadData(String.Format("Usp_Records_GetPatientAge '{0}'", strBirthDate))
        With Myds.Tables(0).Rows(0)
            If .Item("AgeYear") <> 0 Then
                Age = .Item("AgeYear").ToString & " Year(s)"
            Else
                If .Item("AgeMonths") <> 0 Then

                    Age = .Item("AgeMonths") & " Months(s)"
                Else
                    Age = .Item("AgeDays") & " Day(s)"
                End If

            End If
        End With
23:
        Return Age
    End Function


    Public Function CheckForInternetConnection() As Boolean
        'Try
        '    Return My.Computer.Network.Ping("www.google.com")
        'Catch
        '    Return False
        'End Try
    End Function

    Public Function Decrypt(ByVal cipherText As String) As String
        Dim EncryptionKey As String = "MAKV2SPBNI99212"
        Dim cipherBytes As Byte() = Convert.FromBase64String(cipherText)
        Using encryptor As Aes = Aes.Create()
            Dim pdb As New Rfc2898DeriveBytes(EncryptionKey, New Byte() {&H49, &H76, &H61, &H6E, &H20, &H4D, &H65, &H64, &H76, &H65, &H64, &H65, &H76})
            encryptor.Key = pdb.GetBytes(32)
            encryptor.IV = pdb.GetBytes(16)
            Using ms As New MemoryStream()
                Using cs As New CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write)
                    cs.Write(cipherBytes, 0, cipherBytes.Length)
                    cs.Close()
                End Using
                cipherText = Encoding.Unicode.GetString(ms.ToArray())
            End Using
        End Using
        Return cipherText
    End Function


    Public Function Encrypt(ByVal clearText As String) As String
        Dim EncryptionKey As String = "MAKV2SPBNI99212"
        Dim clearBytes As Byte() = Encoding.Unicode.GetBytes(clearText)
        Using encryptor As Aes = Aes.Create()
            Dim pdb As New Rfc2898DeriveBytes(EncryptionKey, New Byte() {&H49, &H76, &H61, &H6E, &H20, &H4D, &H65, &H64, &H76, &H65, &H64, &H65, &H76})
            encryptor.Key = pdb.GetBytes(32)
            encryptor.IV = pdb.GetBytes(16)
            Using ms As New MemoryStream()
                Using cs As New CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write)
                    cs.Write(clearBytes, 0, clearBytes.Length)
                    cs.Close()
                End Using
                clearText = Convert.ToBase64String(ms.ToArray())
            End Using
        End Using
        Return clearText
    End Function

    Public Sub SendMSM(ByVal smsMsg As String, smsPhoneNumber As String, smsAPIKey As String, smsSender As String)
        smsErrMsg = ""
        Try
            ' set host
            NotifyRequest.setHost("api.smsonlinegh.com")
            Dim sr As SMSRequest = New SMSRequest

            ' set authentication details.
            sr.setAuthModel(AuthModel.API_KEY)
            sr.setAuthApiKey(smsAPIKey)

            ' message properties
            sr.setMessage(smsMsg)
            sr.setMessageType(TextMessageType.TEXT)
            sr.setSender(smsSender)        ' should be registered

            ' add message destination
            sr.addDestination(smsPhoneNumber)

            ' send message
            sr.submit()

        Catch ex As Exception
            ' output error message
            smsErrMsg = ex.Message

        End Try

    End Sub

End Module
