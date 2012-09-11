<% 

function json_list()
    
    rtype = request("type")

    if rtype = "science" then
        sqlstr = "select *, 'science' as type from science where hash <> '' order by id"
    end if

    if rtype = "notice" then
        sqlstr = "select *, 'notice' as type from notice where hash <> '' order by id"
    end if

    set rs = conn.execute(sqlstr)

    response.write json(rs)
    
    conn.close()    
    set rs = nothing

end function

%>