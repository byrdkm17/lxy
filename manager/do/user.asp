<%

function do_user()

    id = request("id")
    username = request("username")
    passwd = request("passwd")
    state = request("state")
    usertype = request("type")
    is_del = request("is_del")

    if is_del <> "" then

        sqlstr = "delete from users where id = " & id
        conn.execute(sqlstr)

    else

        if id = "" then

            set rs = conn.execute("select * from users where username = '" & username & "'")

            if rs.bof and rs.eof then
                sqlstr = "insert into users (username, passwd, state, type) values " & "('" & username & "', '" & md5(passwd) & "', " & state & ", " & usertype & ")"
                conn.execute(sqlstr)
            else
                response.write "error 0"
            end if

        else

            set rs = conn.execute("select * from users where username = '" & username & "' and id <> " & id)

            if rs.bof and rs.eof then
                if passwd = "" then
                    sqlstr = "update users set username = '" & username & "', state = " & state & ", type = " & usertype & " where id = " & id
                else
                    sqlstr = "update users set username = '" & username & "', passwd = '" & md5(passwd) & "', state = " & state & ", type = " & usertype & " where id = " & id
                end if
                conn.execute(sqlstr)
            else
                response.write "error 0"
            end if    

        end if

    end if    

    conn.close
    set rs = nothing

end function

%>