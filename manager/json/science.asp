<% 

function json_science()

    id = request("id")
    edit = request("edit")
    title = request("title")

    if edit = "" then
        if title = "" then
            set rs = conn.execute("select * from science where hash is null order by create_time desc")
        else
            set rs = conn.execute("select * from science where  hash is null and title like '%" & title & "%' order by create_time desc")
        end if
    else 
        set rs = conn.execute("select * from science where id = " & id)
    end if

    response.write json(rs)
    conn.close()    
    set rs = nothing

end function

%>