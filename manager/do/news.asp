<%

function do_news()

    id = request("id")
    abstract = request("abstract")
    title = request("title")
    content = request("content")
    img_url = request("img_url")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from news where id = " & id

    else    

        if id = "" then
            if img_url = "" then
                sqlstr = "insert into news (abstract, title, author, content, create_time) values " & "('" & abstract & "', '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "')"
            else
                sqlstr = "insert into news (abstract, title, author, content, create_time, img_url) values " & "('" & abstract & "', '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "', '" & img_url & "')"
            end if
        else
            if img_url = "" then
                sqlstr = "update news set title = '" & title & "', abstract = '" & abstract & "', content = '" & content & "' where id = " & id
            else
                sqlstr = "update news set title = '" & title & "', abstract = '" & abstract & "', content = '" & content & "', img_url = '" & img_url & "' where id = " & id
            end if
        end if

    end if

    conn.execute(sqlstr)
    conn.close

end function

%>