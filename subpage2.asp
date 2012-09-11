<!--#include file="handler/base.asp"-->

    <div class="container subpage">
        <div class="row-fluid">
          <div class="span2">
            <div class="dropdown clearfix">
              <!--#include file="handler/set_nav.asp"-->
              <%
                dim sqlstr, artid, menuid, navid
                menuid = request("menuid")
                artid = request("artid")
                navid = request("navid")
                if navid<>"" then
                  sqlstr = "select "
                elseif artid<>"" then
                  sqlstr = "select title from article inner join menu on article.menu_id = menu.id"
                elseif menuid<>"" then
                  
                end if
                set nav= new view_nav
                call nav.output(navid)
              %>
            </div>
          </div>
          <div class="span9 content">
            <!--#include file="handler/query_art.asp"-->
            <%
                set art = new viewArt
                call art.viewer(navid,menuid,id)
            %>
          </div>
        </div>
    </div>
<!--#include file="handler/footer.asp"-->
<script type="text/javascript">
  
</script>