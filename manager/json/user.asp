<% 

function json_user()

    id = request("id")
    edit = request("edit")

    if edit = "" then
        set rs = conn.execute("select * from users order by id")
    else 
        set rs = conn.execute("select * from users where id = " & id)
    end if

    response.write json(rs)
    conn.close()    
    set rs = nothing

end function

%>