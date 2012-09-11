<div class="container footer">
    <ul class="pull-right">
        <li class="disabled">推荐使用 <a href="http://chrome.google.com" target="_blank">Chrome</a> 或 <a href="http://firefox.com.cn/" target="_blank">Firefox</a> 浏览器, 以获得更好的体验</li>
        <li class="static">2012 &copy; <a href="#">林学院</a></li>
    </ul>
</div>

<div id="footer-sctipts" style="display:none;">
    <script src="res/js/jquery-1.8.0.min.js"></script>
    <script src="res/bootstrap/js/bootstrap.min.js"></script>
    <script src="res/kindeditor/kindeditor.js"></script>
    <script src="res/kindeditor/lang/zh_CN.js"></script>
    <script src="res/kindeditor/plugins/code/prettify.js"></script>
    <script src="res/js/juicer.js"></script>
    <script src="res/js/manage/base.js"></script>
    <% 
    select case page:
        case "login": response.write "<script src=""res/js/manage/login.js""></script>"
        case "site": response.write "<script src=""res/js/manage/site.js""></script>"
        case "content": 
            select case cur:
                case "article": response.write "<script src=""res/js/manage/content/article.js""></script>"
                case "notice": response.write "<script src=""res/js/manage/content/notice.js""></script>"
                case "science": response.write "<script src=""res/js/manage/content/science.js""></script>"
                case "news": response.write "<script src=""res/js/manage/content/news.js""></script>"
                case else: response.write "<script src=""res/js/manage/content/article.js""></script>"
            end select
        case "remote": 
            select case cur:
                case "source": response.write "<script src=""res/js/manage/remote/source.js""></script>"
                case "notice": response.write "<script src=""res/js/manage/remote/notice.js""></script>"
                case "science": response.write "<script src=""res/js/manage/remote/science.js""></script>"
                case else: response.write "<script src=""res/js/manage/remote/source.js""></script>"
            end select
        case "other": 
            select case cur:
                case "message": response.write "<script src=""res/js/manage/other/message.js""></script>"
                case "people": response.write "<script src=""res/js/manage/other/people.js""></script>"
                case "calendar": response.write "<script src=""res/js/manage/other/calendar.js""></script>"
                case else: response.write "<script src=""res/js/manage/other/message.js""></script>"
            end select
        case "auth": response.write "<script src=""res/js/manage/auth/user.js""></script>"
    end select
    %>
</div>

</div>
</body>
</html>