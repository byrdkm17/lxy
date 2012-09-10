<!--#include file="commons/conn.asp" -->
<!--#include file="commons/json.asp" -->
<%  

  dim action
  action = request("action")

  select case action:    

    case "article": %> <!--#include file="json/article.asp" -->
    <% call json_article()

    case "menu": %> <!--#include file="json/menu.asp" -->
    <% call json_menu()

    case "news": %> <!--#include file="json/news.asp" -->
    <% call json_news()

    case "notice": %> <!--#include file="json/notice.asp" -->
    <% call json_notice()

    case "science": %> <!--#include file="json/science.asp" -->
    <% call json_science()

    case "session": %> <!--#include file="json/session.asp" -->
    <% call json_session()

    case "sub": %> <!--#include file="json/sub.asp" -->
    <% call json_sub()

    case "user": %> <!--#include file="json/user.asp" -->
    <% call json_user()

  end select

%>