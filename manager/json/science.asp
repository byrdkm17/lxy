<!--#include file="../conn.asp" -->
<!--#include file="json.asp" -->
<% 

    dim edit, id, title, rs

    id = request("id")
    edit = request("edit")
    title = request("title")


    if edit = "" then
        if title = "" then
            set rs = conn.execute("select * from science order by create_time desc")
        else
            set rs = conn.execute("select * from science where title like '%" & title & "%' order by create_time desc")
        end if
    else 
        set rs = conn.execute("select * from science where id = " & id)
    end if

    response.write json(rs)

    conn.close()
    
    set rs = nothing

%>