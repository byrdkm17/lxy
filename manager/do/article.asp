<%

function do_article()
    
    on error resume next

    id = request("id")
    menu_id = request("menu_id")
    title = request("title")
    content = request("content")
    img_url = request("img_url")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from article where id = " & id

    else

        if img_url = "" then
            img_url = "null"
        else
            img_url = "'" & img_url & "'"
        end if

        if id = "" then
            sqlstr = "insert into article (menu_id, title, author, content, create_time, img_url) values " & "(" & menu_id & ", '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "', " & img_url & ")"

        else
            sqlstr = "update article set title = '" & title & "', content = '" & content & "', img_url = " & img_url & " where id = " & id

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