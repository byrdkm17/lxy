
 <%
 response.write request.ServerVariables("SCRIPT_NAME")
url = server.mappath("../")
response.write url
 %>
