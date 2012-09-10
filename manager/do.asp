<!--#include file="commons/md5.asp" -->
<!--#include file="commons/conn.asp" -->

<%  

  dim action
  action = request("action")

  select case action:
    case "article": %> <!--#include file="do/article.asp" -->
        <% call do_article()

    case "login": %> <!--#include file="do/login.asp" -->
        <% call do_login()

    case "menu": %> <!--#include file="do/menu.asp" -->
        <% call do_menu()

    case "news": %> <!--#include file="do/news.asp" -->
        <% call do_news()

    case "notice": %> <!--#include file="do/notice.asp" -->
        <% call do_notice()

    case "science": %> <!--#include file="do/science.asp" -->
        <% call do_science()

    case "sub": %> <!--#include file="do/sub.asp" -->
        <% call do_sub()

    case "user": %> <!--#include file="do/user.asp" -->
        <% call do_user()

  end select

%>