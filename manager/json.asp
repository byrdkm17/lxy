<!--#include virtual="/handler/conn.asp" -->
<!--#include file="commons/json.asp" -->
<%  

  dim action
  action = request("action")

  select case action:    

    case "article": %> <!--#include file="json/article.asp" -->
    <% call json_article()

    case "calendar": %> <!--#include file="json/calendar.asp" -->
    <% call json_calendar()

    case "menu": %> <!--#include file="json/menu.asp" -->
    <% call json_menu()

    case "message": %> <!--#include file="json/message.asp" -->
    <% call json_message()

    case "news": %> <!--#include file="json/news.asp" -->
    <% call json_news()

    case "notice": %> <!--#include file="json/notice.asp" -->
    <% call json_notice()

    case "people": %> <!--#include file="json/people.asp" -->
    <% call json_people()

    case "science": %> <!--#include file="json/science.asp" -->
    <% call json_science()

    case "session": %> <!--#include file="json/session.asp" -->
    <% call json_session()

    case "source": %> <!--#include file="json/source.asp" -->
    <% call json_source()

    case "sub": %> <!--#include file="json/sub.asp" -->
    <% call json_sub()

    case "user": %> <!--#include file="json/user.asp" -->
    <% call json_user()

    case "list": %> <!--#include file="json/list.asp" -->
    <% call json_list()

  end select

%>