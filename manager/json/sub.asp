<%

function json_sub()

    id = request("id")
    parent_id = request("parent_id")
    edit = request("edit")
    subtype = request("type")

    if edit = "" then
        select case subtype:
            case 1:
                set rs = conn.execute("select menu_name as name, sub as type, * from menu where nav_id = " & id & " and parent_id = 0 order by id")
            case 2:
                set rs = conn.execute("select menu_name as name, sub as type, * from menu where parent_id = " & id & " order by id")                
            case 3:
                set rs = conn.execute("select menu_name as name, sub as type, * from menu where nav_id = " & id & " order by id")
            case 4:
                set rs = conn.execute("select menu_name as name, sub as type, * from menu where sub = 0 and nav_id = " & id & " order by id")
            case 5:
                set rs = conn.execute("select menu_name as name, sub as type, * from menu where sub = 1 and nav_id = " & id & " order by id")
            case else:
                set rs = conn.execute("select menu_name as name, sub as type, * from menu order by id")
        end select
    else 
        set rs = conn.execute("select menu_name as name, sub as type, * from menu where id = " & id)
    end if

    response.write json(rs)
    conn.close()    
    set rs = nothing

end function

%>