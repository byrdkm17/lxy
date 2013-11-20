<%
codepage="65001"
Response.Charset="utf-8"
Session.CodePage = 65001

On Error Resume Next

set conn=Server.CreateObject("ADODB.Connection")

with conn
	.Provider = "Microsoft.Jet.OLEDB.4.0"
	.Properties("data source") = server.MapPath("/") & "/db/lxy.mdb"
	.Properties("Jet OLEDB:database password") = "lydxlxy@2012"
	.Open
End with

If Err Then	
	Set Conn = Nothing
	Response.Write "database can't access! (" + Err.Source + " : " + Err.description + ")"
	Response.End
	Err.Clear
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