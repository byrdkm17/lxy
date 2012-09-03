<div id="manage-menu">

<div class="manage-menu-nav">
    <ul class="breadcrumb">
        <li class="active">菜单列表</li>        
        <li class="icon pull-right"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i> 刷新</a></li>
        <li class="icon pull-right add" style="display: none; "><a href="#" class="add"><i class="icon-plus" rel="tooltip" title="添加"></i><span class="tip"></span></a></li>
    </ul>
</div>

<table class="table table-striped menu-list">
    <colgroup>
        <col width="80">
        <col>
        <col width="100">
        <col width="100">
        <col width="60">
        <col width="60">
        <col width="60">
    </colgroup>
    <thead>
        <tr>
        	<th class="center">菜单 ID</th>
        	<th>菜单名称</th>
        	<th class="center">菜单顺序</th>
        	<th class="center">菜单类型</th>
            <th class="center">管理</th>
        	<th class="center">编辑</th>
        	<th class="center">删除</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>
<table class="table table-striped article-list" style="display: none; ">
    <colgroup>
        <col width="80">
        <col>
        <col width="100">
        <col width="100">
        <col width="100">
        <col width="150">
        <col width="60">
        <col width="60">
    </colgroup>
    <thead>
        <tr>
            <th class="center">文章 ID</th>
            <th>文章标题</th>
            <th class="center">作者</th>
            <th class="center">文章类别</th>
            <th class="center">图片新闻</th>
            <th class="center">发布时间</th>
            <th class="center">编辑</th>
            <th class="center">删除</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>

<div class="modal hide" id="nav-modal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>导航编辑</h3>
    </div>
    <div class="modal-body">
        <form class="form-horizontal">

            <div class="control-group">
                <label class="control-label" for="name">导航名称</label>
                <div class="controls">
                    <input type="text" name="name" id="name" class="submitValue required">
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="seq">显示顺序</label>
                <div class="controls">
                    <input type="text" name="seq" id="seq" class="submitValue">
                    <span class="help-inline">* 使用数字</span>
                </div>
            </div>        
            <div class="control-group">
                <label class="control-label" for="type">导航类型</label>
                <div class="controls">
                    <select name="type" id="type" class="submitValue">
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
                    <input type="text" name="link" id="link" class="submitValue">
                    <span class="help-inline"></span>
                </div>
            </div>
            <input type="hidden" name="id" id="id" class="submitValue">
        </form>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn closem">Close</a>
        <a href="#" class="btn btn-primary savem">保存</a>
    </div>
</div>

<div class="modal hide" id="sub-modal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>菜单编辑</h3>
    </div>
    <div class="modal-body">
        <form class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="nav_id">导航菜单</label>
                <div class="controls">
                    <select name="nav_id" id="nav_id" class="submitValue"></select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="parent_id">父级菜单</label>
                <div class="controls">
                    <select name="parent_id" id="parent_id" class="submitValue"></select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">菜单名称</label>
                <div class="controls">
                    <input type="text" name="name" id="name" class="submitValue required">
                    <span class="help-inline"></span>
                </div>
            </div>            
            <div class="control-group">
                <label class="control-label" for="seq">显示顺序</label>
                <div class="controls">
                    <input type="text" name="seq" id="seq" class="submitValue">
                    <span class="help-inline">* 使用数字</span>
                </div>
            </div>        
            <div class="control-group">
                <label class="control-label" for="type">菜单类型</label>
                <div class="controls">
                    <select name="type" id="type" class="submitValue">
                        <option value="0">文章列表</option>
                        <option value="1">菜单列表</option>
                    </select>
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group c-g-link" style="display: none; ">
                <label class="control-label" for="link">链接地址</label>
                <div class="controls">
                    <input type="text" name="link" id="link" class="submitValue">
                    <span class="help-inline"></span>
                </div>
            </div>
            <input type="hidden" name="id" id="id" class="submitValue">
        </form>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn closem">Close</a>
        <a href="#" class="btn btn-primary savem">保存</a>
    </div>
</div>

<div class="modal hide" id="article-modal" style="width: 80%; margin: -300px 0 0 -40%;">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>文章编辑</h3>
    </div>
    <div class="modal-body" style="max-height: 600px">
        <form class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="nav_id">标题</label>
                <div class="controls">
                    <input name="title" id="title" type="text" class="span12 submitValue required">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="menu_name">类别</label>
                <div class="controls">
                    <input type="text" name="menu_name" id="menu_name" disabled class="span12">
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
                    <input type="text" name="img_url" id="img_url" class="span12 submitValue">
                </div>
            </div>
            <textarea name="content" id="content" style="width:100%;height:300px;visibility:hidden;"></textarea>
            <input type="hidden" name="id" id="id" class="submitValue">
        </form>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn closem">Close</a>
        <a href="#" class="btn btn-primary savem">保存</a>
    </div>
</div>

</div>