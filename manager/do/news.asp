<%

function do_news()

    on error resume next

    id = request("id")
    abstract = request("abstract")
    title = request("title")
    content = request("content")
    img_url = request("img_url")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from news where id = " & id

    else    

        if img_url = "" then
            img_url = "null"
        else
            img_url = "'" & img_url & "'"
        end if

        if id = "" then
            sqlstr = "insert into news (abstract, title, author, content, create_time, img_url) values " & "('" & abstract & "', '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "', " & img_url & ")"
        else
            sqlstr = "update news set title = '" & title & "', abstract = '" & abstract & "', content = '" & content & "', img_url = " & img_url & " where id = " & id
        end if

    end if

    conn.execute(sqlstr)
    conn.close

    if err then
        response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
        err.clear
    end if

end function

%>