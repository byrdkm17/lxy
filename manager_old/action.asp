<%@ CODEPAGE=65001 %>
<!--#include file="md5.asp" -->
<!--#include file="conn.asp" -->
<%
Response.CodePage=65001
Response.Charset="UTF-8"
dim action
action = request("act")


select case action:
	case "login":
		call login()
	case "notice":
		call add_notice()
	case "news":
		call add_news()
	case "nav":
		call add_nav()
	case "del":
		call delrecoder()
	case "updatenav":
		call update_nav()
	case "updatenews":
		call update_news()
	case else:
end select

function login():
	user=request("username")
	passwd =request("password")
	if (user="" or passwd ="") then
		response.write("<script language=javascript>alert('用户名密码不能为空！');location.href='login.asp';</script>")
		response.end
	else
		'set rs=Server.CreateObject("ADODB.recordset")
		set rs= conn.execute("select * from [users] where username='"&user&"'")
		if not (rs.eof and rs.bof) then
			if rs.fields("passwd") = md5(passwd) then
				session("username")=user
				response.redirect("manage.asp")
			else
				response.write("<script language=javascript>alert('登录验证失败！');location.href='login.asp';</script>")
			end if	
		else
			response.write("<script language=javascript>alert('登录验证失败！');location.href='login.asp';</script>")
		end if
	end if
	conn.close()
	set rs=nothing
end function
function add_notice():
	menu_id = 20000
	title=request("title")
	author= session("username")
	create_time = now()
	content=request("content1")
	sqlstr = "INSERT INTO article (menu_id,title,"
	sqlstr=sqlstr & "author,content,create_time) VALUES"
	sqlstr=sqlstr & "("&menu_id&",'"&title&"','"&author&"','"&content&"','"&create_time&"')"
	
	on error resume next
	conn.execute sqlstr
	if err<>0 then
	  Response.Write("<script language=javascript>alert('添加失败！');location.href='manage.asp?act=notice';</script>")
	else
	  Response.Write("<script language=javascript>alert('添加成功！');location.href='manage.asp';</script>")
	end if
	conn.close
end function

function add_news():
	menu_id = request("parent_id")
	title = request ("title")
	author = session("username")
	create_time = now()
	content = request("content1")
	img_url = request("img_url")
	if img_url <> "" then
		sqlstr = "insert into article (menu_id, title, author, content,create_time,img_url) values"
		sqlstr = sqlstr &"("& menu_id &",'"&title&"','"&author&"','"&content&"','"&create_time&"','"&img_url&"')"
	else
		sqlstr = "insert into article (menu_id, title, author, content,create_time) values"
		sqlstr = sqlstr &"("& menu_id &",'"&title&"','"&author&"','"&content&"','"&create_time&"')"
	end if
	conn.execute(sqlstr)
	if err<>0 then
	  Response.Write("<script language=javascript>alert('添加失败！');location.href='manage.asp?act=news';</script>")
	else
	  Response.Write("<script language=javascript>alert('添加成功！');location.href='manage.asp?act=news';</script>")
	end if
	conn.close
end function

function update_news():
	id = int(request("id"))
	title = request ("title")
	content = request("content1")
	img_url = request("img_url")
	if img_url <> "" then
		sqlstr = "update article set title='"&title&"',content='"&content&"',img_url='"&img_url&"' where id="&id
	else
		sqlstr = "update article set title='"&title&"',content='"&content&"'where id="&id
	end if
	conn.execute(sqlstr)
	if err<>0 then
	  Response.Write("<script language=javascript>alert('编辑失败！');location.href='manage.asp?act=article';</script>")
	else
	  Response.Write("<script language=javascript>alert('编辑成功！');location.href='manage.asp?act=article';</script>")
	end if
	conn.close
end function

function add_nav():
	navid = int(request("nav_id"))
	name = request("menu_name")
	order = int(request("seq"))
	parent = int(request("parent_id"))
	setsub = int(request("sub"))

	sqlstr = "insert into menu (nav_id,menu_name,seq,parent_id,sub) values"
	sqlstr = sqlstr & "("&navid&",'"&name&"',"&order&","&parent&","&setsub&")"
	conn.execute(sqlstr)
	conn.close
end function
function update_nav():
	id = request("id")
	navid = int(request("nav_id"))
	name = request("menu_name")
	order = int(request("seq"))
	parent = int(request("parent_id"))
	setsub = int(request("sub"))

	sqlstr = "update menu set nav_id="&navid&",menu_name='"&name&"',seq="&order&",parent_id="&parent&",sub="&setsub&" where id="&id
	response.Write sqlstr
	conn.execute(sqlstr)
	conn.close
end function
function delrecoder():
	table=request("table")
	id=request("id")
	conn.execute("delete from "& table &" where id="&id)
	if err<>0 then
	  Response.Write("<script language=javascript>alert('删除失败！');location.href='manage.asp?act=notice';</script>")
	else
	  Response.Write("<script language=javascript>alert('删除成功！');location.href='manage.asp';</script>")
	end if
	conn.close
end function
%>


