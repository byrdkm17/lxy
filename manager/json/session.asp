<%
    if session("username") = "" then
        response.write "false"
    end if
%>