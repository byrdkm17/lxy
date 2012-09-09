<% 
    page = "content"

    cur = request("mod")
%>

<div class="container">
    <div class="page-header">
        <h1>内容管理</h1>
    </div>
    <div>
        <ul class="nav nav-tabs">
            <li<% if cur = "article" or cur = "" then %> class="active"<% end if %>><a href="manage.asp?nav=content&mod=article">文章管理</a></li>
            <li<% if cur = "notice" then %> class="active"<% end if %>><a href="manage.asp?nav=content&mod=notice">通知发布</a></li>
            <li<% if cur = "science" then %> class="active"<% end if %>><a href="manage.asp?nav=content&mod=science">科研动态管理</a></li>
            <li<% if cur = "news" then %> class="active"<% end if %>><a href="manage.asp?nav=content&mod=news">学院要闻管理</a></li>
            <li class="pull-right nav-search">
                <div class="input-append">
                    <input class="search" type="text"><button class="btn search" type="button">搜索</button>
                </div>
            </li>
        </ul>     
        <div class="tab-content">
            <div class="tab-pane active" id="<%=cur%>">
                <% select case cur:
                    case "article": %><!--#include file="content_article.asp" -->
                <%  case "notice": %><!--#include file="content_notice.asp" -->
                <%  case "science": %><!--#include file="content_science.asp" -->
                <%  case "news": %><!--#include file="content_news.asp" -->
                <%  case else: %><!--#include file="content_article.asp" -->
                <% end select %>
            </div>
        </div>
    </div>
</div>