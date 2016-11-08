<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="scheme.add" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">


        $(document).ready(function() {

            $("#inputForm").validate({
                submitHandler: function(form){
                    save();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

        });



        function save() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/gen/genScheme/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/gen/genScheme/list.do"/>');
        }


    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="scheme.add" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="genScheme"  method="post" class="cmxform form-horizontal adminex-form">
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.name" />:</label>
                            <div class="col-lg-5">
                                <form:input path="name" htmlEscape="false"  cssErrorClass="error"  maxlength="50"  cssClass="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.category" />:</label>
                            <div class="col-lg-5">
                                <form:select path="category" class="required selectcss">
                                    <form:options items="${config.categoryList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                                </br>
                                生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.packagename" />:</label>
                            <div class="col-lg-5">
                                <form:input path="packageName" htmlEscape="false" maxlength="500" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.modulename" />:</label>
                            <div class="col-lg-5">
                                <form:input path="moduleName" htmlEscape="false" maxlength="500" class="required form-control"/>
                                </br>
                                可理解为子系统名，例如 sys
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.submodulename" />:</label>
                            <div class="col-lg-5">
                                <form:input path="subModuleName" htmlEscape="false" maxlength="500" class="form-control"/>
                                </br>
                                可选，分层下的文件夹
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.functionname" />:</label>
                            <div class="col-lg-5">
                                <form:input path="functionName" htmlEscape="false" maxlength="500" class="required form-control"/>
                                </br>
                                将设置到类描述
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.functionnamesimple" />:</label>
                            <div class="col-lg-5">
                                <form:input path="functionNameSimple" htmlEscape="false" maxlength="500" class="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.functionauthor" />:</label>
                            <div class="col-lg-5">
                                <form:input path="functionAuthor" htmlEscape="false" maxlength="500" class="required form-control"/>
                                </br>
                                功能开发者
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.genTable" />:</label>
                            <div class="col-lg-5">
                                <form:select path="genTable.id" class="required selectcss">
                                    <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="id" htmlEscape="false"/>
                                </form:select>
                                </br>
                                生成的数据表，一对多情况下请选择主表。
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="scheme.replaceFile" />:</label>
                            <div class="col-lg-5">
                                <form:checkbox path="replaceFile" label="是否替换现有文件"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" cssClass="form-control"  cssErrorClass="error" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
                            </div>
                        </div>
                        <form:hidden path="flag"/>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <input id="btnSubmit" class="btn btn-primary" type="submit" onclick="$('#flag').val('0');" value="<spring:message code="save" />"/>
                                <input id="btnSubmit1" class="btn btn-success" type="submit" onclick="$('#flag').val('1');" value="<spring:message code="saveandgen" />"/>
                                <button class="btn btn-default" type="button" onclick="back();"><spring:message code="back" /></button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
