<% 
    page = "remote"

    cur = request("mod")
%>

<div class="container">
    <div class="page-header">
        <h1>数据抓取</h1>
    </div>
    <div>
        <ul class="nav nav-tabs">
            <li<% if cur = "source" or cur = "" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=source">数据源管理</a></li>
            <li<% if cur = "notice" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=notice">西林公告</a></li>
            <li<% if cur = "science" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=science">科研动态</a></li>
        </ul>     
        <div class="tab-content">
            <div class="tab-pane active" id="<%=cur%>">
                <% select case cur:
                    case "source": %><!--#include file="remote\source.asp" -->
                <%  case "notice": %><!--#include file="remote\notice.asp" -->
                <%  case "science": %><!--#include file="remote\science.asp" -->
                <%  case else: %><!--#include file="remote\source.asp" -->
                <% end select %>
            </div>
        </div>
    </div>
</div>