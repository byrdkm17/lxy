<!--#include file="handler/base.asp"-->

    <div class="container subpage">
        <div class="row-fluid">
          <div class="span2">
            <div class="dropdown clearfix">
              <!--#include file="handler/set_nav.asp"-->
              <%
                navid =request("navid")
                menuid = request("menuid")
                id = request("id")
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