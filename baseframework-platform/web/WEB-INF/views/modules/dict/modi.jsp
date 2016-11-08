<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title><spring:message code="dict.modi" /></title>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>

    <script type="text/javascript">

        $(document).ready(function() {
            $("#value").focus();

            $(".sender_user_search").select2({
                theme: "classic",
                ajax: {
                    url: '<c:url value="${fns:getAdminPath()}/dict/type1.do"/>',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term
                        };
                    },
                    processResults: function (data, params) {
                        // parse the results into the format expected by Select2
                        // since we are using custom formatting functions we do not need to
                        // alter the remote JSON data, except to indicate that infinite
                        // scrolling can be used
                        params.page = params.page || 1;

                        return {
                            results: data.items,
                            pagination: {
                                more: (params.page * 30) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
                minimumInputLength: 1,
                templateResult: function (repo) { return repo.text; }, // omitted for brevity, see the source of this page
                templateSelection: function (repo) { return repo.text; } // omitted for brevity, see the source of this page
            });


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
            ajaxSubmitPost('<c:url value="${fns:getAdminPath()}/dict/save.do"/>');
        }

        function back() {
            ajaxGet('<c:url value="${fns:getAdminPath()}/dict/list.do"/>');
        }


    </script>
</head>

<body>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <spring:message code="dict.modi" />
                <span class="tools pull-right">
                    <a href="javascript:;" class="fa fa-chevron-down"></a>
                    <a href="javascript:;" class="fa fa-times"></a>
                 </span>
            </div>
            <div class="panel-body">
                <sys:message content="${message}" type="${flag}"/>

                <div class=" form">
                    <form:form id="inputForm" modelAttribute="dict"  method="post" class="cmxform form-horizontal adminex-form">
                        <form:hidden path="id"/>

                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="dict.value" />:</label>
                            <div class="col-lg-5">
                                <form:input path="value" htmlEscape="false"  cssErrorClass="error"  maxlength="50"  cssClass="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="dict.label" />:</label>
                            <div class="col-lg-5">
                                <form:input path="label" htmlEscape="false"  cssErrorClass="error"  maxlength="50"  cssClass="required form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="dict.type" />:</label>
                            <div class="col-lg-5">
                                <select id="type" name="type" class="sender_user_search required"  style="width: 150px"  >
                                    <option id="<c:out value="${dict.type}"/>"><c:out value="${dict.type}"/></option>
                                </select>

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="dict.description" />:</label>
                            <div class="col-lg-5">
                                <form:input path="description" htmlEscape="false"  cssErrorClass="error"  maxlength="50"  cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-2 ftext"><spring:message code="dict.sort" />:</label>
                            <div class="col-lg-5">
                                <form:input path="sort" htmlEscape="false"  cssErrorClass="error" isNUM="true"   maxlength="50"  cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-lg-2 ftext"><spring:message code="remarks" />:</label>
                            <div class="col-lg-6">
                                <form:textarea path="remarks" cssClass="form-control"  cssErrorClass="error" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <shiro:hasPermission name="sys:dict:edit">
                                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="save" />"/>
                                    &nbsp;</shiro:hasPermission>
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
