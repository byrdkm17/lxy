<%

  if session("username") = "" then
    response.redirect("login.asp")
  end if

%>

<!--#include file="template/header.asp" -->
<%
  dim nav
  nav = request("nav")
  select case nav:
%>
  <% case "site": %> <!--#include file="template/site.asp" -->
  <% case "content": %> <!--#include file="template/content.asp" -->
  <% case "auth": %> <!--#include file="template/auth.asp" -->
<%
  end select
%>
<!--#include file="template/footer.asp" -->