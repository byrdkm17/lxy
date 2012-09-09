<!--#include file="conn.asp" -->
<%

id = request("id")
key = request("key")
value = request("value")

if (id <> "" and key <> "" and value <> "") then
	set rs = conn.execute("update menu set " & key & " = " & value & " where id=" & id)
end if

%>