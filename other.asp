<!--#include file="handler/base.asp"-->

    <div class="container subpage">
        <div class="row-fluid">
          <div class="span2">
            <div class="dropdown clearfix">
              <ul class='dropdown-menu sub-nav' role='menu' aria-labelledby='dropdownMenu' style='display: block; position: static; margin-bottom: 5px; *width: 180px;'>
              <%
                type_=request("type")
                id =request("id")
                select case type_:
                case "notice":
                  if id<>"" then
                    set rs=conn.execute("select * from notice where id="&id)
                  else
                    set rs=conn.execute("select * from notice where type=2 order by create_time")
                  end if
              %>
                <li><a tabindex="-1" href="other.asp?type=notice">学院通知</a></li>
              <%
                case "news":
                  if id<>"" then
                    set rs=conn.execute("select * from news where id="&id)
                  else
                    set rs=conn.execute("select * from news order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="other.asp?type=news">学院要闻</a></li>
                <%
                case "science"
                  if id<>"" then
                    set rs=conn.execute("select * from siteinfo where id="&id)
                  else
                    set rs=conn.execute("select * from siteinfo where type=1 order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="other.asp?type=science">科研动态</a></li>
                <%
                case "swfunotice":
                  if id<>"" then
                    set rs=conn.execute("select * from science where id="&id)
                  else
                    set rs=conn.execute("select * from science order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="other.asp?type=swfunotice">西林公告</a></li>
                <%
                case "mail":
                  if id<>"" then
                    set rs=conn.execute("select * from siteinfo where id="&id)
                  else
                    set rs=conn.execute("select * from siteinfo where type=1 order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="other.asp?type=mail">领导邮箱</a></li>
                <%
                case "recruit":
                 if id<>"" then
                    set rs=conn.execute("select * from siteinfo where id="&id)
                  else
                    set rs=conn.execute("select * from siteinfo where type=2 order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="other.asp?type=recruit">人事招聘</a></li>
                <%
                case "calendar":
                  if id<>"" then
                    set rs=conn.execute("select * from siteinfo where id="&id)
                  else
                    set rs=conn.execute("select * from siteinfo where type=3 order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="other.asp?type=calendar">校历</a></li>
              <%end select%>
              </ul>
            </div>
          </div>
          <div class="span9 content">
            <%
              if not (rs.eof and rs.bof) then
                if id<>"" then
                  Response.Write("<h3 style='text-align:center;'>"&rs.fields("title")&"</h3>")
                  Response.Write("<p style='text-align:center;'><small>"& rs.fields("create_time")&"&nbsp;&nbsp;&nbsp;&nbsp;发布者："&rs.fields("author")&"</small></p>")
                  Response.Write("<p>"&rs.fields("content")&"</p>")
                  else
                    Response.Write("<div class='subcontent'><div class='artlist'><strong>文章列表</strong></div>")
                    Response.Write("<ul class='unstyled'>")
                    do while not rs.eof
                      Response.Write("<li><a href=other.asp?type="&type_&"&id="&rs.fields("id")&">"&cutstr(rs.fields("title"),40)&"</a><em>"&formatdatetime(rs.fields("create_time"),2)&"</em></li>")
                    rs.movenext
                    loop
                    Response.Write("</ul></div>")
                end if
              end if
            %>
          </div>
        </div>
    </div>
<!--#include file="handler/footer.asp"-->
<script type="text/javascript">
  
</script>