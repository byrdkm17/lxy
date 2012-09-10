<%

CodePage = "65001"
Response.Charset = "utf-8"
Session.CodePage = 65001
On Error Resume Next

Dim dbPath, connStr

dbPath = request.servervariables("Appl_Physical_Path") & "db\lxy.mdb"
connStr = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & dbPath & ";Jet OLEDB:Database Password=lydxlxy@2012"

Set conn = Server.CreateObject("ADODB.Connection")

conn.Open connStr

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