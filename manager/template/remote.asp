<% 
    page = "remote"

    cur = request("mod")
%>

<div class="container">
    <div class="page-header">
        <h1>其他</h1>
    </div>
    <div>
        <ul class="nav nav-tabs">
            <li<% if cur = "source" or cur = "" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=source">数据源管理</a></li>
            <% if false then %>
            <li<% if cur = "list" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=list">抓取列表</a></li>
            <% end if %>
        </ul>     
        <div class="tab-content">
            <div class="tab-pane active" id="<%=cur%>">
                <% select case cur:
                    case "source": %><!--#include file="remote\source.asp" -->
                <%  case "list": if false then %><!--#include file="remote\list.asp" --><% end if %>
                <%  case else: %><!--#include file="remote\source.asp" -->
                <% end select %>
            </div>
        </div>
    </div>
</div>