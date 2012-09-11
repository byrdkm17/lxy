<% 
    page = "other"

    cur = request("mod")
%>
<div class="container">
    <div class="page-header">
        <h1>其他</h1>
    </div>
    <div>
        <ul class="nav nav-tabs">
            <li<% if cur = "message" or cur = "" then %> class="active"<% end if %>><a href="manage.asp?nav=other&mod=message">领导邮箱</a></li>
            <li<% if cur = "people" then %> class="active"<% end if %>><a href="manage.asp?nav=other&mod=people">人事招聘</a></li>
            <li<% if cur = "calendar" then %> class="active"<% end if %>><a href="manage.asp?nav=other&mod=calendar">校历</a></li>
            <li class="pull-right nav-search">
                <div class="input-append">
                    <input class="search" type="text"><button class="btn search" type="button">搜索</button>
                </div>
            </li>
        </ul>     
        <div class="tab-content">
            <div class="tab-pane active" id="<%=cur%>">
                <% select case cur:
                    case "message": %><!--#include file="other\message.asp" -->
                <%  case "people": %><!--#include file="other\people.asp" -->
                <%  case "calendar": %><!--#include file="other\calendar.asp" -->
                <%  case else: %><!--#include file="other\message.asp" -->
                <% end select %>
            </div>
        </div>
    </div>
</div>