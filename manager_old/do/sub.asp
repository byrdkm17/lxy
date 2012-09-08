<!--#include file="../conn.asp" -->
<%

   dim id, menu_name, subtype, seq, nav_id, parent_id, is_del, sqlstr

    id = request("id")
    nav_id = request("nav_id")
    menu_name = request("name")
    seq = int(request("seq"))
    subtype = int(request("type"))
    parent_id = int(request("parent_id"))
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from menu where id = " & id

    else    

        if id = "" then
            sqlstr = "insert into menu (nav_id, menu_name, seq, sub, parent_id) values (" & nav_id & ", '" & menu_name & "', " & seq & ", " & subtype & ", " & parent_id & ")"
        else
            sqlstr = "update menu set menu_name = '" & menu_name & "', sub = " & subtype & ", nav_id = " & nav_id & ", seq = " & seq & ", parent_id = " & parent_id & " where id = " & id
        end if

    end if

    conn.execute(sqlstr)

    conn.close

%>