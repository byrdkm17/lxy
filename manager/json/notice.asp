<!--#include file="../conn.asp" -->
<!--#include file="json.asp" -->
<% 

    dim edit, id, content, title, rs

    id = request("id")
    edit = request("edit")
    content = request("content")
    title = request("title")

    if content = "" then

        if edit = "" then
            if title = "" then
                set rs = conn.execute("select * from article where menu_id = 20000 order by create_time desc")
            else
                set rs = conn.execute("select * from article where menu_id = 20000 and title like '%" & title & "%' order by create_time desc")
            end if
        else 
            set rs = conn.execute("select * from article where id = " & id)
        end if

        response.write json(rs)

    else

        set rs = conn.execute("select content from article where id = " & id)

        rs.movefirst

        response.write rs.fields("content")

    end if

    conn.close()
    
    set rs = nothing

%>