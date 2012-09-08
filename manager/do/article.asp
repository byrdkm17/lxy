<!--#include file="../conn.asp" -->
<%

   dim id, menu_id, title, content, img_url, is_del, sqlstr

    id = request("id")
    menu_id = request("menu_id")
    title = request("title")
    content = request("content")
    img_url = request("img_url")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from article where id = " & id

    else       

        if id = "" then
            if img_url = "" then
                sqlstr = "insert into article (menu_id, title, author, content, create_time) values " & "(" & menu_id & ", '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "')"
            else
                sqlstr = "insert into article (menu_id, title, author, content, create_time, img_url) values " & "(" & menu_id & ", '" & title & "', '" & session("username") & "', '" & content & "', '" & now() & "', '" & img_url & "')"
            end if
        else
            if img_url = "" then
                sqlstr = "update article set title = '" & title & "', content = '" & content & "' where id = " & id
            else
                sqlstr = "update article set title = '" & title & "', content = '" & content & "', img_url = " & img_url & " where id = " & id
            end if
        end if

    end if

    conn.execute(sqlstr)

    conn.close

%>