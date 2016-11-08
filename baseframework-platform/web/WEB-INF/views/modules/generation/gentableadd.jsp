<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="table.add" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">


        $(document).ready(function() {

            $("#inputForm").validate({
                submitHandler: function(form){
                    var s = $("#cflag").val();
                    if (s == '1') {
                        save();
                    } else {
                        next();
                    }
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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/gen/genTable/save.do"/>');
        }


        function next() {
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/gen/genTable/form.do"/>');
        }


        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/gen/genTable/list.do"/>');
        }


    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="table.add" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                <c:choose>
                    <c:when test="${empty genTable.name}">
                    <form:form id="inputForm" modelAttribute="genTable"  method="post" class="cmxform form-horizontal adminex-form">
                        <input id="cflag" name="cflag" type="hidden" value="0">

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="table.name" />:</label>
                            <div class="col-lg-5">
                                <form:select path="name" class="selectcss">
                                    <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="next" />"/>
                                &nbsp;
                                <button class="btn btn-default" type="button" onclick="back();"><spring:message code="back" /></button>
                            </div>
                        </div>
                    </form:form>
                    </c:when>
                    <c:otherwise>
                        <form:form id="inputForm" modelAttribute="genTable"  method="post" class="cmxform form-horizontal adminex-form">
                            <form:hidden path="id"/>
                            <input id="cflag" name="cflag" type="hidden" value="1">
                        <fieldset>
                            <legend><spring:message code="table.information" /></legend>
                            <div class="form-group">
                                <label class="control-label col-lg-2 ftext"><spring:message code="table.name" />:</label>
                                <div class="col-lg-5">
                                    <form:input path="name" htmlEscape="false" maxlength="200" class="required form-control" readonly="true"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-2 ftext"><spring:message code="table.comments" />:</label>
                                <div class="col-lg-5">
                                    <form:input path="comments" htmlEscape="false" maxlength="200" class="required form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-2 ftext"><spring:message code="table.className" />:</label>
                                <div class="col-lg-5">
                                    <form:input path="className" htmlEscape="false" maxlength="200" class="required  form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-2 ftext"><spring:message code="table.parentTable" />:</label>
                                <div class="col-lg-5">
                                    <form:select path="parentTable" cssClass="selectcss">
                                        <form:option value="">无</form:option>
                                        <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-2 ftext"><spring:message code="table.parentTableFk" />:</label>
                                <div class="col-lg-5">
                                    <form:select path="parentTableFk" cssClass="selectcss">
                                        <form:option value="">无</form:option>
                                        <form:options items="${genTable.columnList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
                                    </form:select>
                                   <br> <span class="help-inline">如果有父表，请指定父表表名和外键</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-2 ftext"><spring:message code="remarks" />:</label>
                                <div class="col-lg-5">
                                    <form:textarea path="remarks" htmlEscape="false" maxlength="200" class="form-control"/>
                                </div>
                            </div>
                         </fieldset>
                         <fieldset>
                             <legend><spring:message code="table.colinformation" /></legend>
                             <div class="form-group">
                                <div class="col-lg-5" style="height:80%; width: 100%; overflow:auto">
                                <table id="contentTable"  class="table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th title="数据库字段名"><spring:message code="col.name" /></th>
                                            <th title="默认读取数据库字段备注"><spring:message code="col.explain" /></th>
                                            <th title="数据库中设置的字段类型及长度"><spring:message code="col.physical" /></th>
                                            <th title="实体对象的属性字段类型"><spring:message code="col.javatype" /></th>
                                            <th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）"><spring:message code="col.nature" /><i class="icon-question-sign"></i></th>
                                            <th title="是否是数据库主键"><spring:message code="col.pk" /></th>
                                            <th title="字段是否可为空值，不可为空字段自动进行空值验证"><spring:message code="col.isnull" /></th>
                                            <th title="选中后该字段被加入到insert语句里"><spring:message code="col.insert" /></th>
                                            <th title="选中后该字段被加入到update语句里"><spring:message code="col.modi" /></th>
                                            <th title="选中后该字段被加入到查询列表里"><spring:message code="col.list" /></th>
                                            <th title="选中后该字段被加入到查询条件里"><spring:message code="col.query" /></th>
                                            <th title="该字段为查询字段时的查询匹配放松"><spring:message code="col.querymatch" /></th>
                                            <th title="字段在表单中显示的类型"><spring:message code="col.formtype" /></th>
                                            <th title="显示表单类型设置为“下拉框、复选框、单选框”时，需设置字典的类型"><spring:message code="col.dicttype" /></th>
                                            <th><spring:message code="col.sort" />排序</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${genTable.columnList}" var="column" varStatus="vs">
                                        <tr${column.delFlag eq '1'?' class="error" title="已删除的列，保存之后消失！"':''}>
                                            <td nowrap>
                                                <input type="hidden" name="columnList[${vs.index}].id" value="${column.id}"/>
                                                <input type="hidden" name="columnList[${vs.index}].delFlag" value="${column.delFlag}"/>
                                                <input type="hidden" name="columnList[${vs.index}].genTable.id" value="${column.genTable.id}"/>
                                                <input type="hidden" name="columnList[${vs.index}].name" value="${column.name}"/>${column.name}
                                            </td>
                                            <td>
                                                <input type="text" name="columnList[${vs.index}].comments" value="${column.comments}" maxlength="200" class="required" style="width:70px;"/>
                                            </td>
                                            <td nowrap>
                                                <input type="hidden" name="columnList[${vs.index}].jdbcType" value="${column.jdbcType}"/>${column.jdbcType}
                                            </td>
                                            <td>
                                                <select name="columnList[${vs.index}].javaType" class="required input-mini" style="width:75px;*width:75px">
                                                    <c:forEach items="${config.javaTypeList}" var="dict">
                                                        <option value="${dict.value}" ${dict.value==column.javaType?'selected':''} title="${dict.description}">${dict.label}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="text" name="columnList[${vs.index}].javaField" value="${column.javaField}" maxlength="200" class="required input-mini"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''}/>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="columnList[${vs.index}].isNull" value="1" ${column.isNull eq '1' ? 'checked' : ''}/>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="columnList[${vs.index}].isInsert" value="1" ${column.isInsert eq '1' ? 'checked' : ''}/>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="columnList[${vs.index}].isEdit" value="1" ${column.isEdit eq '1' ? 'checked' : ''}/>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="columnList[${vs.index}].isList" value="1" ${column.isList eq '1' ? 'checked' : ''}/>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="columnList[${vs.index}].isQuery" value="1" ${column.isQuery eq '1' ? 'checked' : ''}/>
                                            </td>
                                            <td>
                                                <select name="columnList[${vs.index}].queryType" class="required input-mini">
                                                    <c:forEach items="${config.queryTypeList}" var="dict">
                                                        <option value="${fns:escapeHtml(dict.value)}" ${fns:escapeHtml(dict.value)==column.queryType?'selected':''} title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="columnList[${vs.index}].showType" class="required" style="width:80px;">
                                                    <c:forEach items="${config.showTypeList}" var="dict">
                                                        <option value="${dict.value}" ${dict.value==column.showType?'selected':''} title="${dict.description}">${dict.label}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="text" name="columnList[${vs.index}].dictType" value="${column.dictType}" maxlength="200" class="input-mini"/>
                                            </td>
                                            <td>
                                                <input type="text" name="columnList[${vs.index}].sort" value="${column.sort}" maxlength="200" class="required input-min digits"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                </div>
                            </div>
                             <div class="form-group">
                                 <div class="col-lg-offset-2 col-lg-10">
                                     <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="save" />"/>
                                     &nbsp;
                                     <button class="btn btn-default" type="button" onclick="back();"><spring:message code="back" /></button>
                                 </div>
                             </div>
                        </fieldset>
                        </form:form>

                    </c:otherwise>
                </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
