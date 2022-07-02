<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
    function allClick() {
        //取得当前全选复选框的选中状态
        //#后面的all是复选框的id
        var state=$("#all").prop("checked");
        //将此状态赋值给每个商品列表里的复选框
        $("input[name=ck]").each(function () {
            this.checked=state;
        });
    }

    function ckClick() {
        //所有name=ck被选中的复选框
        var checkedLen = $("input[name=ck]:checked").length;
        //所有name=ck的复选框
        var num = $("input[name=ck]").length;
        //比较
        if(num == checkedLen){
            $("#all").prop("checked",true);
        }else
        {
            $("#all").prop("checked",false);
        }
    }
</script>
<body>
<div id="brall">
    <div id="nav">
        <p>商品管理>商品列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            商品名称：<input name="productName" id="productName">&nbsp;&nbsp;&nbsp;
            商品类型：<select name="productType" id="productType">
            <option value="-1">请选择</option>
            <c:forEach items="${typeList}" var="type">
                <option value="${type.typeId}">${type.typeName}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;&nbsp;
            价格：<input name="lowPrice" id="lowPrice">-<input name="highPrice" id="highPrice">
            <input type="button" value="查询" onclick="condition()">
<%--            ajaxsplit(${info.pageNum})--%>
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="btn1"
                               value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="批量删除" onclick="deleteBatch(${info.pageNum})">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>商品名</th>
                            <th>商品介绍</th>
                            <th>定价（元）</th>
                            <th>商品图片</th>
                            <th>商品数量</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${info.list}" var="p">
                            <tr>
                                <td valign="center" align="center">
                                    <input type="checkbox" name="ck" id="ck" value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="${pageContext.request.contextPath}/image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>
                                    <%--<td><a href="${pageContext.request.contextPath}/admin/product?flag=delete&pid=${p.pId}" onclick="return confirm('确定删除吗？')">删除</a>--%>
                                    <%--&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/product?flag=one&pid=${p.pId}">修改</a></td>--%>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.pId},${info.pageNum})">编辑
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId},${info.pageNum})">删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                            <%-- <a href="${pageContext.request.contextPath}/prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <c:if test="${info.pageNum==i}">
                                            <li>
                                                    <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${info.pageNum!=i}">
                                            <li>
                                                    <%-- <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                        <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">总共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${info.pageNum!=0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <%--处理在最后一页时点击下一页，页码变成0的情况--%>
                                        <c:if test="${info.pageNum==0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的商品！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch(pageNum) {
            //取得所有被选中删除商品的pid
            var checkeds=$("input[name=ck]:checked");
            if(checkeds.length == 0){
                alert("请选择要批量删除的商品！");
            }else{

                //取出每个选中商品的p_id，拼提交的ID的数据
                if(confirm("您确定要批量删除"+checkeds.length+"条商品吗？")){
                    //取出查询条件
                    var pname = $("#productName").val();
                    var typeid = $("#productType").val();
                    var lprice = $("#lowPrice").val();
                    var hprice = $("#highPrice").val();
                    var str = "";
                    var pid = "";
                //拼接ID
                    $.each(checkeds,function () {
                        //每个被选中的id
                        pid = $(this).val();
                        //非空判断
                        if (pid != null) {
                        str += pid + ",";
                        }
                    });
                    // alert(str);
                    //发送请求到服务器端
                    $.ajax({
                        url:"${pageContext.request.contextPath}/prod/deleteBatch.action",
                        //pids是ProductInfoAction中对应方法名的形参名
                        data:{"pids":str,"pageNum":pageNum,"productName":pname,"productType":typeid,"lowPrice":lprice,"highPrice":hprice},
                        type:"post",
                        //text是弹窗的内容的格式
                        //dataType: "text",
                        success:function(msg){
                            alert(msg);//批量删除成功/失败/不可删除
                            //重新加载容器
                            $("#table").load("http://localhost:8080/admin/product.jsp #table");
                        }
                    }
                )
                }
        }
    }
    //单个删除
    function del(pid,pageNum) {
        //弹框提示
        if (confirm("确定删除吗")) {
            //取出查询条件
            var pname = $("#productName").val();
            var typeid = $("#productType").val();
            var lprice = $("#lowPrice").val();
            var hprice = $("#highPrice").val();
            //向服务器提交ajax请求完成删除
            $.ajax({
                url: "${pageContext.request.contextPath}/prod/delete.action",
                data:{"pid":pid,"productName":pname,"productType":typeid,"lowPrice":lprice,"highPrice":hprice},
                type: "post",
                dataType:"text",
                success:function (msg) {
                    alert(msg);
                    $("#table").load("http://localhost:8080/admin/product.jsp #table");
                    //$("#brall").load("http://localhost:8080/admin/product.jsp #brall");
                }
            })
        }
    }
    // window.location="${pageContext.request.contextPath}/prod/delete.action?pid="+pid;
    function one(pid, pageNum) {
        //取出查询条件
        var pname = $("#productName").val();
        var typeid = $("#productType").val();
        var lprice = $("#lowPrice").val();
        var hprice = $("#highPrice").val();
        <%--$.ajax({--%>
        <%--    type:"post",--%>
        <%--    url:"${pageContext.request.contextPath}/prod/one.action",--%>
        <%--    //"productName"是vo类中的变量名，pname是上述取出的var的变量名--%>
        <%--    data:{"pid":pid,"pageNum":pageNum,"productName":pname,"productType":typeid,"lowPrice":lprice,"highPrice":hprice},--%>
        <%--    success:function () {--%>
        <%--        //刷新table容器--%>
        <%--        $("#table").load("http://localhost:8080/admin/product.jsp #table");--%>
        <%--    }--%>
        <%--});--%>
        var str = "?pid="+pid+"&pageNum="+pageNum+"&pname="+pname+"&typeid="+typeid+"&lprice="+lprice+"&hprice"+hprice;
        //向服务器提交请求，传递商品Id
        //问号后面的pid需与ProductInfoAction中/one方法的参数名一致
        // + "&page=" + ispage
       location.href = "${pageContext.request.contextPath}/prod/one.action" + str;
    }

    function condition(){
        //取出查询条件
        var pname = $("#productName").val();
        var typeid = $("#productType").val();
        var lprice = $("#lowPrice").val();
        var hprice = $("#highPrice").val();
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/prod/ajaxSplit.action",
            //"productName"是vo类中的变量名，pname是上述取出的var的变量名
            data:{"productName":pname,"productType":typeid,"lowPrice":lprice,"highPrice":hprice},
            success:function () {
                //刷新table容器
                $("#table").load("http://localhost:8080/admin/product.jsp #table");
            }
        });
    }
</script>

<!--分页的AJAX实现-->
<script type="text/javascript">
    function ajaxsplit(page) {
        var pname = $("#productName").val();
        var typeid = $("#productType").val();
        var lprice = $("#lowPrice").val();
        var hprice = $("#highPrice").val();
        //异步ajax分页请求
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/prod/ajaxSplit.action",
            data:{"pageNum":page,"productName":pname,"productType":typeid,"lowPrice":lprice,"highPrice":hprice},
            success:function () {
                //重新加载分页显示的组件table
                //location.href---->http://localhost:8080/admin/login.action
                $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table");
            }
        });
    }
</script>

</html>