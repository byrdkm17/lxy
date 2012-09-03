
 <%
class view_nav:
private sqlstr0
private rs1, navrs, navrs1
public sub output(navid):
  if navid ="" then
    response.write("<script language=javascript>alert('获取参数异常001！');location.href='index.asp';</script>")
  end if
  response.write("<ul class='dropdown-menu sub-nav' role='menu' aria-labelledby='dropdownMenu' style='display: block; position: static; margin-bottom: 5px; *width: 180px;'>")                  
  set rs1=Server.CreateObject("ADODB.recordset")
  sqlstr0 = "select * from menu where nav_id="&navid &" order by seq asc"
  rs1.open sqlstr0, conn, 1, 2
  set navrs =rs1.clone(1)
  set navrs1 = rs1.clone(1)

  do while not navrs.EOF
    if navrs.fields("parent_id")=0 then  

      if navrs.fields("sub") then
        dim pid
        pid= navrs.fields("id")
        response.write("<li class='dropdown-submenu'><a tabindex='-1' href='#'>"&cutstr(navrs.fields("menu_name"),8)&"</a>")
        navrs1.filter = "parent_id="&pid   
        response.write("<ul class='dropdown-menu'>")
        
        do while not navrs1.eof
          
          if navrs1.fields("sub") then
            dim pid1
            pid1 =navrs1.fields("id")
            rs1.filter = "parent_id="& pid1 
            response.write("<li class='open dropdown-submenu'><a tabindex='-1' href='#'>"&cutstr(navrs1.fields("menu_name"),8)&"</a>")
            response.write("<ul class='dropdown-menu'>")

            do while not rs1.eof
              response.write("<li><a tabindex='-1' href='subpage.asp?navid="&navid&"&menuid="&rs1.fields("id")&"'>"&cutstr(rs1.fields("menu_name"),8)&"</a></li>")
            rs1.MoveNext
            loop
            response.write("</ul></li>")
          else
            response.write("<li><a tabindex='-1' href='subpage.asp?navid="&navid&"&menuid="&navrs1.fields("id")&"'>"&cutstr(navrs1.fields("menu_name"),8)&"</a></li>")
          end if
        navrs1.MoveNext
        loop
        response.write("</ul></li>")
      else
        response.write("<li><a tabindex='-1' href='subpage.asp?navid="&navid&"&menuid="&navrs.fields("id")&"'>"&cutstr(navrs.fields("menu_name"),8)&"</a></li>")
      end if
    end if
navrs.MoveNext
loop
rs1.close
set rs1=nothing
response.write("</ul>")
end sub
end class
%>
