<%
edit = request("edit")
id = request("id")

if (edit<>"" and id <> "") then
	set rs = conn.execute("select * from menu where id="&request("id"))
%>
<form class="form-horizontal" method="post" action="action.asp?act=updatenav&id=<%=id%>">
	<legend>菜单编辑</legend>
	<label>
		导 航 ID
		<input type="text" name="navid" value=<%=rs.fields("nav_id")%> />
	</label>
	<label>
		菜单名称
		<input type="text" name="menu_name" value=<%=rs.fields("menu_name")%>>
	</label>
	<label>
		显示顺序
		<input type="text" name="menu_order" value=<%=rs.fields("seq")%>>*使用数字
	</label>
	<label>
		父菜单ID
		<input type="text" name="parent_id" value=<%=rs.fields("parent_id")%>>*使用数字
	</label>
	<label>
		子菜单位
		<input type="text" name="sub" value=<%=rs.fields("sub")%>>*使用0或1
	</label>
	<div class="control-group">
    <div class="controls">
    	<br/>
      <button type="submit" class="btn">提交</button>
    </div>
  </div>
</form>
<%else%>
<form class="form-horizontal" method="post" action="action.asp?act=nav">
	<legend>菜单编辑</legend>
	<label>
		导 航 ID
		<input type="text" name="navid" value=0>
	</label>
	<label>
		菜单名称
		<input type="text" name="menu_name">
	</label>
	<label>
		显示顺序
		<input type="text" name="menu_order" value=0>*使用数字
	</label>
	<label>
		父菜单ID
		<input type="text" name="parent_id" value=0>*使用数字
	</label>
	<label>
		子菜单位
		<input type="text" name="sub" value=0>*使用0或1
	</label>
	<div class="control-group">
    <div class="controls">
    	<br/>
      <button type="submit" class="btn">提交</button>
    </div>
  </div>
</form>
<%end if%>