﻿<div class="container footer">
    <ul>
        <li class="static">2012 &copy; <a href="#">林学院</a></li>
        <li class="static"><a href="#">关于</a></li>
    </ul>
</div>

<div id="footer-sctipts" style="display:none;">
    <script src="res/js/jquery-1.8.0.min.js"></script>
    <script src="res/bootstrap/js/bootstrap.min.js"></script>
    <script src="res/kindeditor/kindeditor.js"></script>
    <script src="res/kindeditor/lang/zh_CN.js"></script>
    <script src="res/kindeditor/plugins/code/prettify.js"></script>
    <script src="res/js/juicer.js"></script>
    <script src="res/js/manage.base.js"></script>
    <% 
    select case page:
        case "login": response.write "<script src=""res/js/manage.login.js""></script>"
        case "site": response.write "<script src=""res/js/manage.site.js""></script>"
        case "content": 
            select case cur:
                case "article": response.write "<script src=""res/js/manage.content.article.js""></script>"
                case "notice": response.write "<script src=""res/js/manage.content.notice.js""></script>"
                case "science": response.write "<script src=""res/js/manage.content.science.js""></script>"
                case "news": response.write "<script src=""res/js/manage.content.news.js""></script>"
                case else: response.write "<script src=""res/js/manage.content.article.js""></script>"
            end select
    end select
    %>
</div>

</div>
</body>
</html>