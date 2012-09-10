<%

function json_menu()

    id = request("id")
    edit = request("edit")
    subtype = request("type")

    if edit = "" then
        where = "where 1 = 1 "
        if subtype <> "" then
            where = where & " and type = " & subtype
        end if
        set rs = conn.execute("select *, 1 as is_nav from nav " & where & " order by seq, id")
    else 
        set rs = conn.execute("select *, 1 as is_nav from nav where id = " & id)
    end if

    response.write json(rs)

    conn.close()    
    set rs = nothing

end function

%>