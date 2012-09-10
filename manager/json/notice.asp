<% 

function json_notice()

    id = request("id")
    edit = request("edit")
    content = request("content")
    title = request("title")

    if content = "" then

        if edit = "" then
            if title = "" then
                set rs = conn.execute("select * from notice order by create_time desc")
            else
                set rs = conn.execute("select * from notice where title like '%" & title & "%' order by create_time desc")
            end if
        else 
            set rs = conn.execute("select * from notice where id = " & id)
        end if

        response.write json(rs)

    else

        set rs = conn.execute("select content from notice where id = " & id)
        rs.movefirst
        response.write rs.fields("content")

    end if

    conn.close()    
    set rs = nothing

end function

%>