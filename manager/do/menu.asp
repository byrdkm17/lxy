<!--#include file="../conn.asp" -->
<%

    dim id, name, subtype, link, seq, is_del, sqlstr

    id = request("id")
    name = request("name")
    subtype = int(request("type"))
    link = request("link")
    seq = int(request("seq"))
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from nav where id = " & id

    else

        if id = "" then
            sqlstr = "insert into nav (name, type, link, seq) values ('" & name & "', " & subtype & ", '" & link & "', " & seq & ")"
        else
            sqlstr = "update nav set name = '" & name & "', type = " & subtype & ", link = '" & link & "', seq = " & seq & " where id = " & id
        end if

    end if

    conn.execute(sqlstr)

    conn.close

%>