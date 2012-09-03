<!--#include file="handler/base.asp"-->

    <div class="container subpage">
        <div class="row-fluid">
          <div class="span2">
            <div class="dropdown clearfix">
              <ul class='dropdown-menu sub-nav' role='menu' aria-labelledby='dropdownMenu' style='display: block; position: static; margin-bottom: 5px; *width: 180px;'>
              <%
                type_=request("type")
                id =request("id")
                if type_="notice" then
                  if id<>"" then
                    set rs=conn.execute("select * from article where id="&id)
                  else
                    set rs=conn.execute("select * from article where menu_id=20000 order by create_time")
                  end if
              %>
                <li><a tabindex="-1" href="subpage.asp?navid=">学院通知</a></li>
              <%
                elseif type_="news" then
                  if id<>"" then
                    set rs=conn.execute("select * from news where id="&id)
                  else
                    set rs=conn.execute("select * from news order by create_time")
                  end if
                %>
                <li><a tabindex="-1" href="subpage.asp?navid=">学院要闻</a></li>
                <%
                elseif type_="science" then
                  if id<>"" then
                    set rs=conn.execute("select * from science where id="&id)
                  else
                    set rs=conn.execute("select * from science order by create_time")
                  end if
              %>
                <li><a tabindex="-1" href="subpage.asp?navid=">科研动态</a></li>
              <%end if%>
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
                    Response.Write("<ul>")
                    do while not rs.eof
                      Response.Write("<li><a href=other.asp?type="&type_&"&id="&rs.fields("id")&">"&rs.fields("title")&"</a></li>")
                    rs.movenext
                    loop
                    Response.Write("</ul>")
                end if
              end if
            %>
          </div>
        </div>
    </div>
<!--#include file="handler/footer.asp"-->
<script type="text/javascript">
  
</script>