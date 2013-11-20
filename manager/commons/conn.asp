<%
codepage="65001"
Response.Charset="utf-8"
Session.CodePage = 65001

On Error Resume Next

set conn=Server.CreateObject("ADODB.Connection")

with conn
    .Provider = "Microsoft.Jet.OLEDB.4.0"
    .Properties("data source") = server.MapPath("../")&"/db/lxy.mdb"
    .Properties("Jet OLEDB:database password") = "lydxlxy@2012"
    .Open
End with

If Err Then

Set Conn = Nothing

Response.Write "数据库连接出错,请联系管理员解决此问题! <br><br> 错误信息 : [" & Err.Number & "] " & Err.description & "(" & Err.Source & ")"
Response.End

Err.Clear

End If
function cutstr(str,len_):
	len_ = int(len_)
	if (str ="" or len_="" or len_=0) Then
		cutstr="error!"
		exit function
	elseif len(str) > len_ then
		cutstr = left(str,len_) & "..."
	else
		cutstr= trim(str)
	end if
end function

On Error GoTo 0

%>