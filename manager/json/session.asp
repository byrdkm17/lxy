<%

function json_session()

    if session("username") = "" then
        response.write "false"
    end if

end function

%>