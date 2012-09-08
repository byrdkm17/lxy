<!--#include file="../conn.asp" -->
<!--#include file="json.asp" -->
<% 

    dim edit, id, content, all, title, rs

    id = request("id")
    edit = request("edit")
    content = request("content")
    all = request("all")
    title = request("title")

    if all = "" then

        if content = "" then

            if edit = "" then
                set rs = conn.execute("select a.*, m.menu_name from article a left join menu m on m.id = a.menu_id where a.menu_id = " & id & " order by a.create_time desc")
            else 
                set rs = conn.execute("select a.*, m.menu_name from article a left join menu m on m.id = a.menu_id where a.id = " & id)
            end if

            response.write json(rs)

        else

            set rs = conn.execute("select content from article where id = " & id)

            rs.movefirst

            response.write rs.fields("content")            

        end if

    else
        if title = "" then
            set rs = conn.execute("select a.*, m.menu_name from article a left join menu m on m.id = a.menu_id where a.menu_id <> 20000 order by a.create_time desc" )
        else
            set rs = conn.execute("select a.*, m.menu_name from article a left join menu m on m.id = a.menu_id where a.title like '%" & title & "%' and a.menu_id <> 20000 order by a.create_time desc" )
        end if
        response.write json(rs)

    end if

    conn.close()
    
    set rs = nothing

%>