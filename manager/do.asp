<!--#include file="commons/md5.asp" -->
<!--#include file="../handler/conn.asp" -->

<%  

    CodePage = "65001"
    Response.Charset = "utf-8"
    Session.CodePage = 65001

  dim action
  action = request("action")

  select case action:
    case "article": %> <!--#include file="do/article.asp" -->
        <% call do_article()

    case "calendar": %> <!--#include file="do/calendar.asp" -->
        <% call do_calendar()

    case "login": %> <!--#include file="do/login.asp" -->
        <% call do_login()

    case "menu": %> <!--#include file="do/menu.asp" -->
        <% call do_menu()

    case "message": %> <!--#include file="do/message.asp" -->
        <% call do_message()

    case "news": %> <!--#include file="do/news.asp" -->
        <% call do_news()

    case "notice": %> <!--#include file="do/notice.asp" -->
        <% call do_notice()

    case "people": %> <!--#include file="do/people.asp" -->
        <% call do_people()

    case "science": %> <!--#include file="do/science.asp" -->
        <% call do_science()

    case "source": %> <!--#include file="do/source.asp" -->
        <% call do_source()

    case "sub": %> <!--#include file="do/sub.asp" -->
        <% call do_sub()

    case "user": %> <!--#include file="do/user.asp" -->
        <% call do_user()

    case "asyn": %> <!--#include file="remote.asp" -->
        <% call getAll()

    case "get": %> <!--#include file="remote.asp" -->
        <% call getOne()
        
  end select

%>