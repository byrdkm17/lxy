<div class="content-page">
    <div class="nav-menu">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right list"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i></a></li>
            <li class="icon pull-right list add" style="display: none; "><a href="#" class="addm"><i class="icon-file" rel="tooltip" title="新增"></i></a></li>
            <li class="icon pull-right single" style="display: none; "><a href="#" class="closem"><i class="icon-remove" rel="tooltip" title="关闭"></i></a></li>
        </ul>
    </div>
    <div class="list">
        <div class="table">

            <table class="table menu-list">
                <colgroup>
                    <col width="60">
                    <col>
                    <col width="100">
                    <col width="100">
                    <col width="60">
                    <col width="150">
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th>菜单名称</th>
                        <th class="center">菜单顺序</th>
                        <th class="center">菜单类型</th>
                        <th class="center">管理</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>

            <table class="table article-list" style="display: none; ">
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

    <div class="editMenu edit" style="display: none; " id="menu">

        <form class="well form-horizontal">
            <div class="control-group">
                <label class="control-label" for="name">名称</label>
                <div class="controls">
                    <input type="text" name="name" id="name" class="submitValue required span6">
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="seq">显示顺序</label>
                <div class="controls">
                    <input type="text" name="seq" id="seq" class="submitValue span6">
                    <span class="help-inline">* 使用数字</span>
                </div>
            </div>        
            <div class="control-group">
                <label class="control-label" for="type">类型</label>
                <div class="controls">
                    <select name="type" id="type" class="submitValue span6">
                        <option value="0">文章列表</option>
                        <option value="1">菜单列表</option>
                        <option value="2">外部链接</option>
                    </select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group c-g-link" style="display: none; ">
                <label class="control-label" for="link">链接地址</label>
                <div class="controls">
                    <input type="text" name="link" id="link" class="submitValue span6">
                    <span class="help-inline"></span>
                </div>
            </div>
            <input type="hidden" name="id" id="id" class="submitValue">
            <div class="form-actions">
                <div class="pull-right">
                    <button type="button" class="btn span1 closem">关闭</button>
                    <button type="button" class="btn btn-primary span1 savem">保存</button>
                </div>
            </div>
        </form>       

    </div>

    <div class="editSub edit" style="display: none; " id="sub">

        <form class="well form-horizontal">
            <div class="control-group">
                <label class="control-label" for="nav_id">导航菜单</label>
                <div class="controls">
                    <select name="nav_id" id="nav_id" class="submitValue span6"></select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="parent_id">父级菜单</label>
                <div class="controls">
                    <select name="parent_id" id="parent_id" class="submitValue span6"></select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">菜单名称</label>
                <div class="controls">
                    <input type="text" name="name" id="name" class="submitValue required span6">
                    <span class="help-inline"></span>
                </div>
            </div>            
            <div class="control-group">
                <label class="control-label" for="seq">显示顺序</label>
                <div class="controls">
                    <input type="text" name="seq" id="seq" class="submitValue span6">
                    <span class="help-inline">* 使用数字</span>
                </div>
            </div>        
            <div class="control-group">
                <label class="control-label" for="type">菜单类型</label>
                <div class="controls">
                    <select name="type" id="type" class="submitValue span6">
                        <option value="0">文章列表</option>
                        <option value="1">菜单列表</option>
                    </select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group c-g-link" style="display: none; ">
                <label class="control-label" for="link">链接地址</label>
                <div class="controls">
                    <input type="text" name="link" id="link" class="submitValue span6">
                    <span class="help-inline"></span>
                </div>
            </div>
            <input type="hidden" name="id" id="id" class="submitValue">
            <div class="form-actions">
                <div class="pull-right">
                    <button type="button" class="btn span1 closem">关闭</button>
                    <button type="button" class="btn btn-primary span1 savem">保存</button>
                </div>
            </div>
        </form>       

    </div>

    <div class="editArticle edit" style="display: none; " id="article">

        <form class="well form-horizontal">
            <div class="control-group">
                <label class="control-label" for="nav_id">标题</label>
                <div class="controls">
                    <input name="title" id="title" type="text" class="submitValue required span6">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="menu_name">类别</label>
                <div class="controls">
                    <input type="text" name="menu_name" id="menu_name" disabled class="span6">
                    <input type="hidden" name="menu_id" id="menu_id" class="submitValue">
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
                    <input type="text" name="img_url" id="img_url" class="submitValue span6">
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