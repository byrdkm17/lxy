<% 

function json_people()

    id = request("id")
    edit = request("edit")
    content = request("content")
    title = request("title")

    if content = "" then

        if edit = "" then
            if title = "" then
                set rs = conn.execute("select * from siteinfo where type = 2 order by create_time desc")
            else
                set rs = conn.execute("select * from siteinfo where type = 2 and title like '%" & title & "%' order by create_time desc")
            end if
        else 
            set rs = conn.execute("select * from siteinfo where id = " & id)
        end if

        response.write json(rs)

    else

        set rs = conn.execute("select content from siteinfo where id = " & id)
        rs.movefirst
        response.write rs.fields("content")

    end if

    conn.close()    
    set rs = nothing

end function

%>