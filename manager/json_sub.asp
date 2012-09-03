<!--#include file="conn.asp" -->
<%
    dim json, id, rs, edit

    id = request("id")
    edit = request("edit")

    if id = "" then
        id = 0
    end if

    if edit = "" then

        set rs = conn.execute("select * from menu where parent_id = " & id & " order by seq, id asc")

    else 

        set rs = conn.execute("select * from menu where id = " & id)

    end if

    json = "["

    if rs.bof and rs.eof then

    else

    rs.movefirst    

    do while not rs.eof

    json = json & "{"
    json = json & """id"":" & rs.fields("id") & ","
    json = json & """menu_name"":""" & rs.fields("menu_name") & ""","
    json = json & """seq"":" & rs.fields("seq") & ","
    json = json & """sub"":" & rs.fields("sub") & ","
    json = json & """parent_id"":" & rs.fields("parent_id")
    json = json & "},"

    rs.movenext

    loop

    json = left(json, len(json) - 1)

    end if

    json = json & "]"

    response.write json

%>