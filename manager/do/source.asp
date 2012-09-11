<%

function do_source()

    id = request("id")
    pattern = replace(request("pattern"), "'", "''")
    url = request("url")
    stype = request("type")
    cycle = request("cycle")
    is_del = request("is_del")

    response.write pattern

    if is_del <> "" then

        sqlstr = "delete from remote where id = " & id

    else    

        if id = "" then
            sqlstr = "insert into remote (url, type, cycle, pattern) values " & "('" & url & "', '" & stype & "', " & cycle & ", '" & pattern & "')"

        else
            sqlstr = "update remote set url = '" & url & "', type = '" & stype & "', cycle = " & cycle & ", pattern = '" & pattern & "' where id = " & id
        end if

    end if

    conn.execute(sqlstr)
    conn.close

end function

%>