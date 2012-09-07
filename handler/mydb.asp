<%
codepage="65001"
Response.Charset="utf-8"
Session.CodePage = 65001

Class QuickDb
Private Conn, ConnStr
'Private SqlDatabaseName, SqlPassword, SqlUsername, SqlLocalName, SqlNowString
private DbPassword, filepath
Public rs
Private Sub Class_Initialize()
    DbPassword= "lydxlxy@2012"
    filepath = server.MapPath("./")&"/db/lxy.mdb"
''    SqlDatabaseName = "db"
''    SqlUsername = "sa"
''    SqlPassword = "123456"
''    SqlLocalName = "a01"
''    SqlNowString = "GetDate()"
''    OpenDb
''
End Sub

Private Sub OpenDb()
    On error resume next
    'ConnStr = "Provider = Sqloledb; User ID = " & SqlUsername & "; Password = " & Replace(SqlPassword, Chr(0), "") & ";Initial Catalog = " & SqlDatabaseName & "; Data Source = " & SqlLocalName & ";"
    ConnStr = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& filepath &";Jet OLEDB:Database Password="& DbPassword 
    Set Conn = CreateObject("ADODB.Connection")
    Conn.Open ConnStr
    If Err Then
        Err.Clear
        Set Conn = Nothing
        On error goto 0
        Err.Raise 1, "MyClass", "Can't connect Database!"
    End If
    Set rs = server.createobject("ADODB.Recordset")
End Sub

Public Sub SetRs(strsql,CursorAndLockType)
    dim c,l
    if CursorAndLockType="" then
        CursorAndLockType=13
    end if
    if CursorAndLockType<9 then
        CursorAndLockType=13
    end if
    c=left(CursorAndLockType,1)
    l=right(CursorAndLockType,1)
    rs.Open strsql, Conn, c,l
End Sub

public Sub Execute(sql,OutRs)
    if instr(Ucase(sql),Ucase("select"))>0 then
        Set OutRs = Conn.Execute(sql)
    else
        Call Conn.Execute(sql)
        OutRs=1
    end if
End Sub

Public Sub SelectDb(Table, Where,OutRs)
    Dim sqlstr
    sqlstr = "Select * from " & Table & " Where " & Where
    Call Execute(sqlstr,OutRs)
End Sub

Public Function Delete(Table, Where)
    Dim Flag, sqlstr,NullTmp
    Flag = False
    On Error Resume Next
    sqlstr = "delete from " & Table & " where " & Where
    Execute sqlstr,NullTmp
    If Err.Number = 0 Then
        Flag = True
    End If
    Delete = Flag
End Function

Public Function Insert(Table, MyFields, Values)
    Dim sql,NullTmp
    Insert = False
    sql = "INSERT INTO Table1(fields) VALUES (values)"
    sql = Replace(sql, "Table1", Table)
    sql = Replace(sql, "fields", MyFields)
    sql = Replace(sql, "values", Values)
    On error Resume next
    Execute sql,NullTmp
    If Err.Number = 0 Then
        Insert = True
    End if
    On error goto 0
End Function

Public Function Update(Table,Field,Value,Where)
    Update=False
    Dim SqlStr
    If SqlInject(Table) or SqlInject(Field) then
        Response.write "参数中含有不安全因素，程序被终止"
        Exit Function
    end if
    SqlStr="Update [Table] Set [Field]=Value Where Where1"
    SqlStr=Replace(SqlStr,"Table",Table)
    SqlStr=Replace(SqlStr,"Field",Field)
    SqlStr=Replace(SqlStr,"Value",Value)
    SqlStr=Replace(SqlStr,"Where1",Where)
    On error resume next
    Dim QDb,TmpRs
    Set QDb=new QuickDb
    Call QDb.Execute(SqlStr,TmpRs)
    if err.number=0 then
        If TmpRs=1 then
            Update=True
        End if
    end if
    Set QDb=Nothing
    On error goto 0
End Function

Function SqlInject(ByVal SqlStr)
    SqlInject = True
    Dim TmpStr, ArrStr, OriginalLen
    TmpStr = "'',',or,not,and,--, ,chr,asc"
    OriginalLen = Len(SqlStr)
    ArrStr = Split(TmpStr, ",")
    TmpStr = UCase(TmpStr)
    For i = 0 To UBound(ArrStr)
        SqlStr = Replace(SqlStr, UCase(ArrStr(i)), "")
    Next
    If Len(SqlStr) = OriginalLen Then
        SqlInject = False
    End If
End Function

Private Sub Class_Terminate()
    If IsObject(Conn) Then
        If Conn.State <> 0 Then
            Conn.Close
            Set Conn = Nothing
        End If
    End If

    If IsObject(rs) Then
        If rs.State <> 0 Then
            rs.Close
            Set rs = Nothing
        End If
    End If
End Sub
End Class
%>