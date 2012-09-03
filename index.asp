<!--#include file="handler/base.asp"-->
   
    <div class="container">
        <div class="row-fluid content part0">
          <div id="myCarousel" class="carousel slide span8">
             <div class="carousel-inner">
              <%
                set rs11 = conn.execute("select top 4 title ,img_url from article where img_url is not null order by create_time")
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
            <h4><i class="icon-th-list"></i>学院要闻</h4>
            <ul class="unstyled">
              <%
                set rs12 = conn.execute("select top 2 id,title ,abstract from news order by create_time")
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
              else
              %>
              <li>
                <h5>我校国际学院泰国喃篷职业技术学院分院挂牌</h5>
                <p>应泰国喃篷职业技术学院院长阿吨.拼通博士邀请，经我校领导审批，对外合作交流处处长兼国际学院院长赵林森...</p>

              </li>
              <li>
                <h5>体育部召开新学期全体教师教学工作会议</h5>
                <p> 8月25日上午，体育部领导班子及全体教研室、中心主任对新学期的工作进行了统一部署。下午3点，体育部在体...</p>
              </li>
              <%end if%>

            </ul>
      		</div>
      	</div>

	    <div class="row-fluid part1" style="margin-top:8px;">
          <div class="span3 pic_nav content ">
            <ul>
              <li><a href="#"><img src="content/img/dh_01.png" alt="网上办公" /></a><br/>网上办公</li>
              <li><a href="#"><img src="content/img/dh_02.png" alt="领导信箱" /></a><br/>领导信箱</li>
              <li><a href="#"><img src="content/img/dh_03.png" alt="邮件查询" /></a><br/>邮件查询</li>
              <li><a href="#"><img src="content/img/dh_04.png" alt="图书资源" /></a><br/>图书资源</li>
              <li><a href="#"><img src="content/img/dh_05.png" alt="人事招聘" /></a><br/>人事招聘</li>
              <li><a href="#"><img src="content/img/dh_06.png" alt="校历" /></a><br \>校历</li>
            </ul>
          </div>
       		<div class="span5 tabbable ">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab11" data-toggle="tab">科研动态</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab11">
    	        	<ul class="unstyled science">
                  <%
                  set rs13 = conn.execute("select top 4 title ,url from science order by create_time")
                  if not (rs13.eof  and rs13.bof) then 
                  rs13.movefirst
                  do while not rs13.eof 
                  %>
    	        		<li><a href="<%=rs13.fields("url")%>"><%=cutstr(rs13.fields("title"),20)%></a></li>
                  <%
                  rs13.movenext
                  loop
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
              </div>
            </div>
        	</div>

      	</div>
      </div>
<!--#include file="handler/footer.asp"-->

