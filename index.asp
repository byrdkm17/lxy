<!--#include file="handler/base.asp"-->
   
    <div class="container">
        <div class="row-fluid content part0">
          <div id="myCarousel" class="carousel slide span8">
             <div class="carousel-inner">
              <%
                set rs11 = conn.execute("select top 4 title ,img_url from article where img_url is not null order by create_time desc")
                if not (rs11.eof  and rs11.bof) then 
                  rs11.movefirst
              %>
              <div class="active item">
                <img src="<%=rs11.fields("img_url")%>"  alt />
                <div class="carousel-caption">
                      <h4><%=rs11.fields("title")%></h4> 
                </div>
              </div>
              <%
                rs11.movenext
                do while not rs11.eof
              %>
              <div class="item">
                <img src="<%=rs11.fields("img_url")%>"  alt />
                <div class="carousel-caption">
                      <h4><%=rs11.fields("title")%></h4> 
                </div>
              </div>
              <% 
                rs11.movenext
                loop
                rs11.close
                set rs11=nothing
              else %>
              <div class="active item">
                <img src="content/img/item01.png"  alt />
                <div class="carousel-caption">
                      <h4>图片说明1</h4> 
                </div>
              </div>
              <div class="item">
                <img src="content/img/item02.png"  alt />
                <div class="carousel-caption">
                      <h4>图片说明2</h4>
                </div>
              </div>
              <div class="item">
                <img src="content/img/item03.png"  alt />
                <div class="carousel-caption">
                      <h4>图片说明3</h4>
                </div>
              </div>
              <div class="item">
                <img src="content/img/item04.png"  alt />
                <div class="carousel-caption">
                      <h4>图片说明4</h4>
                </div>
              </div>
              <% end if%>
            </div>
            <!-- Carousel nav -->
            <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
            <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
          </div>
          <div class="span3 news">
            <div class="more" style="background: url("../../content/img/news_bg.png") left bottom no-repeat;">
              <h4><i class="icon-th-list" style="margin-right:5px;"></i>学院要闻</h4>
              <a href="other.asp?type=news"><img src="content/img/more.gif" /></a>
            </div>
            <ul class="unstyled">
              <%
                set rs12 = conn.execute("select top 2 id,title ,abstract from news order by create_time  desc")
              if not (rs12.eof  and rs12.bof) then 
                rs12.movefirst
                do while not rs12.eof
              %>
              <li>
                <a href='other.asp?type=news&id=<%=rs12.fields("id")%>'>
                  <h5><%=cutstr(rs12.fields("title"),30)%></h5>
                  <p><%=cutstr(rs12.fields("abstract"),50)%></p>
                </a>
              </li>
              <%
                rs12.movenext
                loop
                rs12.close
                set rs12=nothing
                end if
              %>
            </ul>
          </div>
        </div>

      <div class="row-fluid part1" style="margin-top:8px;">
          <div class="span3">
            <div class="content  pic_nav row"  >
              <ul>
                <li><a href="http://oa.swfu.edu.cn/thinkeroa/"><img src="content/img/dh_01.png" alt="OA办公系统" /></a><br/>OA系统</li>
                <li><a href="other.asp?type=mail"><img src="content/img/dh_02.png" alt="领导信箱" /></a><br/>领导信箱</li>
                <li><a href="http://202.203.132.10:8080/postLetterInfoAction.do?method=seachPostByUserNameFramer&userName=&postNumber=133"><img src="content/img/dh_03.png" alt="邮件查询" /></a><br/>邮件查询</li>
                <li><a href="http://lib.swfc.edu.cn/"><img src="content/img/dh_04.png" alt="图书资源" /></a><br/>图书资源</li>
                <li><a href="other.asp?type=recruit"><img src="content/img/dh_05.png" alt="人事招聘" /></a><br/>人事招聘</li>
                <li><a href="other.asp?type=calendar"><img src="content/img/dh_06.png" alt="校历" /></a><br \>校历</li>
              </ul>
            </div>
            <div class="row content" style="width:220px;">
              <img src="content/img/zs.png" />
            </div>
          </div>
          
          <div class="span5">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab11" data-toggle="tab">西林公告</a></li>
              <li><a href="#tab12" data-toggle="tab">科研动态</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab11">
                <ul class="unstyled science">
                  <%
                  set rs13 = conn.execute("select top 4 title ,url from notice where type=1 order by id, create_time desc")
                  if not (rs13.eof  and rs13.bof) then 
                  rs13.movefirst
                  do while not rs13.eof 
                  %>
                  <li><a href="<%=rs13.fields("url")%>"><%=cutstr(rs13.fields("title"),20)%></a></li>
                  <%
                  rs13.movenext
                  loop
                  rs13.close
                  set rs13=nothing
                  end if
                  %>
                </ul>
              </div>              
              <div class="tab-pane" id="tab12">
                <ul class="unstyled science">
                  <%
                  set rs13 = conn.execute("select top 4 title ,url from science order by id, create_time desc ")
                  if not (rs13.eof  and rs13.bof) then 
                  rs13.movefirst
                  do while not rs13.eof 
                  %>
                  <li><a href="<%=rs13.fields("url")%>"><%=cutstr(rs13.fields("title"),20)%></a></li>
                  <%
                  rs13.movenext
                  loop
                  rs13.close
                  set rs13=nothing
                  end if
                  %>
                </ul>
              </div>
            </div>
          </div>
          <div class="span4 tabbable">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab21" data-toggle="tab">学院通知</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab21">
                <ul class="unstyled notice">
                  <!--#include file="handler/query_art.asp"-->
                  <%
                    set list_notice = new viewArt
                    call list_notice.query_notice()
                  %>
                </ul>
                <div class="more" >
                  <a href="other.asp?type=notice"><img src="content/img/more2.gif" /></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<!--#include file="handler/footer.asp"-->

