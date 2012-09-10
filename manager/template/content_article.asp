<div class="content-page">
    <div class="nav-menu">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right list"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i></a></li>
            <li class="icon pull-right list"><a href="#" class="addm"><i class="icon-file" rel="tooltip" title="新增"></i></a></li>
            <li class="icon pull-right single" style="display: none; "><a href="#" class="closem"><i class="icon-remove" rel="tooltip" title="关闭"></i></a></li>
        </ul>
    </div>
    <div class="list">
        <div class="table">

            <table class="table">
                <colgroup>
                    <col width="60">
                    <col>
                    <col width="100">
                    <col width="100">
                    <col width="100">
                    <col width="150">
                    <col width="150">
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th>文章标题</th>
                        <th class="center">作者</th>
                        <th class="center">文章类别</th>
                        <th class="center">图片新闻</th>
                        <th class="center">发布时间</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>

        </div>
    </div>

    <div class="editArticle edit" style="display: none; " id="article">

        <form class="well form-horizontal">
           <div class="control-group">
                <label class="control-label" for="nav_id">标题</label>
                <div class="controls">
                    <input name="title" id="title" type="text" class="span6 submitValue required">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="nav_id">导航菜单</label>
                <div class="controls">
                    <select name="nav_id" id="nav_id" class="span6 submitValue required"></select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="menu_id">类别</label>
                <div class="controls">
                    <select name="menu_id" id="menu_id" class="span6 submitValue required"></select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="set_img">设置为图片新闻</label>
                <div class="controls">
                    <input id="set_img" name="set_img" type="checkbox"> 
                </div>
            </div>
            <div class="control-group c-g-img" style="display: none; ">
                <label class="control-label" for="img_url">图片新闻链接</label>
                <div class="controls">
                    <input type="text" name="img_url" id="img_url" class="span6 submitValue">
                </div>
            </div>
            <textarea name="content" id="editor" style="width:100%;height:300px;visibility:hidden;"></textarea>
            <input type="hidden" name="id" id="id" class="submitValue">
            <div class="form-actions">
                <div class="pull-right">
                    <button type="button" class="btn span1 closem">关闭</button>
                    <button type="button" class="btn btn-primary span1 savem">保存</button>
                </div>
            </div>
        </form>       

    </div>

</div>