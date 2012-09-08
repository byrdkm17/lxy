<%

function do_login():

  dim username, passwd

  username = request("username")
  passwd = request("passwd")

  set rs= conn.execute("select * from users where username = '" & username & "' and passwd = '" & md5(passwd) & "'")
  
  if rs.eof and rs.bof then

    session("error_username") = username
    response.redirect("login.asp")

  else

    session("username") = username
    response.redirect("manage.asp")

  end if

  conn.close()
  set rs = nothing

end function

%>