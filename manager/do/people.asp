<%

function do_people()

    id = request("id")
    title = request("title")
    content = request("content")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from siteinfo where id = " & id

    else    

        if id = "" then
            sqlstr = "insert into siteinfo (title, author, content, create_time, type) values " & "('" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "', 2)"
        else
            sqlstr = "update siteinfo set title = '" & title & "', content = '" & content & "' where id = " & id
        end if

    end if

    conn.execute(sqlstr)
    conn.close

end function

%>