<%
class viewArt:

  private rs,rs1
  'set rs=Server.CreateObject("ADODB.recordset")
  private sub vieweONe():
    Response.Write("<h3 style='text-align:center;'>"&rs.fields("title")&"</h3>")
    Response.Write("<p style='text-align:center;'><small>"& rs.fields("create_time")&"&nbsp;&nbsp;&nbsp;&nbsp;发布者："&rs.fields("author")&"</small></p>")
    Response.Write("<p>"&rs.fields("content")&"</p>")
  end sub

  public sub viewer(navid,menuid,id):
    if navid="" then
      response.write("<script language=javascript>location.href='index.asp';</script>")
    end if
    if id <>"" then
        set rs = conn.execute("select title,author,create_time,content from article where id="&id)
        if not (rs.eof and rs.bof) then
          call vieweONe()
          exit sub
        end if
    elseif menuid<>"" then
    	
    else


    end if

        sqlstr = "select top 1 title,author,create_time,content from article where menu_id= (select top 1 id from menu where nav_id="&navid&" order by id asc) order by id asc"
        set rs = conn.execute(sqlstr)
        if not (rs.eof and rs.bof) then
          call vieweONe()
        else
          Response.Write("<p style='text-align:center;'>暂时没有新的内容！</p>")
        exit sub
        end if
    elseif menuid<>"" then
      set rs1 = conn.execute("select count(*) from article where menu_id="&menuid)
      set rs = conn.execute("select id,title,author,create_time,content from article where menu_id="&menuid)
      if rs1(0) > 1 then
        response.write("<ul>")
        do while not rs.EOF
          response.write("<li><a href='subpage.asp?navid="&navid&"&id="&rs.fields("id")&"'/>"&rs.fields("title")&"</a></li>")
        rs.MoveNext
        loop
        response.write("</ul>")
        set rs= nothing

      elseif rs1(0) = 1 then
        call vieweone()
      else
        Response.Write("<p style='text-align:center;'>暂时没有新的内容！</p>")
      end if
    set rs1=nothing
    set rs=nothing
    else
      response.write("qiguai")
    end if
  end sub

   public sub query_notice():
    set rs = conn.execute("select top 5 id,title, menu_id from  article where menu_id=20000")
    if not (rs.eof and rs.bof) then
      do while not rs.eof
        Response.Write("<li><a href='other.asp?type=notice&id="&rs.fields("id")&"'>"&cutstr(rs.fields("title"),18)&"</a></li>")
        rs.MoveNext
      loop
    else
      Response.Write("暂时没有新的内容！")
    end if
   end sub 
end class
%>