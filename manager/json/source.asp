<%

function json_source()

    id = request("id")
    edit = request("edit")
    pattern = request("pattern")

    if pattern = "" then

        if edit = "" then
            set rs = conn.execute("select * from remote order by id")
        else 
            set rs = conn.execute("select * from remote where id = " & id)
        end if

        response.write json(rs)

    else

        set rs = conn.execute("select pattern from remote where id = " & id)
        rs.movefirst
        response.write rs.fields("pattern")            

    end if

    conn.close()    
    set rs = nothing

end function

%>