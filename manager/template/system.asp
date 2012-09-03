<% CodePage = 65001 %>
<%
	Response.CodePage=65001
	Response.Charset="UTF-8"
	response.write("Service info:</br>")
	response.write("HTTP VERSION:"&Request.ServerVariables("Server_Protocol")&"</br>")
	response.write("SERVICE IP:"&Request.ServerVariables("Server_Name")&"</br>")
	response.write("SERVER PATH:"&Request.ServerVariables("Path_Translated") &"</br>")
	response.write("SERVCICE VERSION:"&Request.ServerVariables("SERVER_SOFTWARE") &"</br>") 
%>