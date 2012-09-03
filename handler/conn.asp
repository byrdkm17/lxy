<%
codepage="65001"
Response.Charset="utf-8"
Session.CodePage = 65001

On Error Resume Next
dim filepath
set conn=Server.CreateObject("ADODB.Connection")
filepath =server.MapPath("./")&"/db/lxy.mdb"
connstr = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& filepath &";Jet OLEDB:Database Password=lydxlxy@2012" 
conn.Open connstr


If Err Then
	err.Clear
	Set Conn = Nothing
	Response.Write "database can't access!"
	Response.End
End If
	On Error GoTo 0

function cutstr(str,len_):
	len_ = int(len_)
	if (str ="" or len_="" or len_=0) Then
		cutstr="截取字符串异常"
		exit function
	elseif len(str) > len_ then
		cutstr = left(str,len_) & "..."
	else
		cutstr= trim(str)
	end if
end function

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
%>