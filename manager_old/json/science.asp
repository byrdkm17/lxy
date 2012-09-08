<!--#include file="../conn.asp" -->
<!--#include file="json.asp" -->
<% 

    dim edit, id, rs

    id = request("id")
    edit = request("edit")


    if edit = "" then
        set rs = conn.execute("select * from science order by create_time desc")
    else 
        set rs = conn.execute("select * from science where id = " & id)
    end if

    response.write json(rs)

    conn.close()
    
    set rs = nothing

%>