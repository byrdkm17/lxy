<!--#include file="conn.asp" -->
<%
    dim json, id, rs, edit

    id = request("id")
    edit = request("edit")

    if id = "" then
        id = 0
    end if

    if edit = "" then

        set rs = conn.execute("select a.*, m.menu_name from article a left join menu m on m.id = a.menu_id where a.menu_id = " & id & " order by a.create_time desc")

    else 

        set rs = conn.execute("select a.*, m.menu_name from article a left join menu m on m.id = a.menu_id where a.id = " & id)

    end if

    

    json = "["

    if rs.bof and rs.eof then

    else

    rs.movefirst    

    do while not rs.eof

    json = json & "{"
    json = json & """id"":" & rs.fields("id") & ","
    json = json & """title"":""" & rs.fields("title") & ""","
    json = json & """author"":""" & rs.fields("author") & ""","
    json = json & """menu_id"":" & rs.fields("menu_id") & ","
    json = json & """menu_name"":""" & rs.fields("menu_name") & ""","
    json = json & """img_url"":""" & rs.fields("img_url") & ""","
    json = json & """create_time"":""" & rs.fields("create_time") & """"
    json = json & "},"

    rs.movenext

    loop

    json = left(json, len(json) - 1)

    end if

    json = json & "]"

    response.write json

%>