<!--#include file="../conn.asp" -->
<%

   dim id, title, content, is_del, sqlstr

    id = request("id")
    title = request("title")
    content = request("content")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from notice where id = " & id

    else    

        if id = "" then
            sqlstr = "insert into notice (title, author, content, create_time) values " & "(20000, '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "')"
        else
            sqlstr = "update article set title = '" & title & "', content = '" & content & "' where id = " & id
        end if

    end if

    conn.execute(sqlstr)

    conn.close

%>