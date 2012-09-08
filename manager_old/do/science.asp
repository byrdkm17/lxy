<!--#include file="../conn.asp" -->
<%

   dim id, title, url, is_del, sqlstr

    id = request("id")
    title = request("title")
    url = request("url")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from science where id = " & id

    else    

        if id = "" then
            sqlstr = "insert into science (title, url, create_time, author) values " & "('" & title & "', '" & url & "', '" & now() & "', '" & session("username") & "')"
        else
            sqlstr = "update science set title = '" & title & "', url = '" & url & "' where id = " & id
        end if

    end if

    conn.execute(sqlstr)

    conn.close

%>