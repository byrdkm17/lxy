<% 

function json_list()

    set rs = conn.execute("select *, 'notice' as type from notice where hash <> '' order by id")

    noticeJson = json(rs)

    set rs = conn.execute("select *, 'science' as type from science where hash <> '' order by id")

    scienceJson = json(rs)

    result = left(noticeJson, len(noticeJson) - 1)

    if scienceJson <> "[]" then
        result = result & "," & right(scienceJson, len(scienceJson) - 1)
    end if

    result = result & right(scienceJson, len(scienceJson) - 1)

    response.write result
    
    conn.close()    
    set rs = nothing

end function

%>