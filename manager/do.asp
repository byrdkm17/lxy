<!--#include file="md5.asp" -->
<!--#include file="conn.asp" -->
<!--#include file="do/login.asp" -->
<%  

  dim action
  action = request("action")

  select case action:
    case "login":
      call do_login()
  end select

%>