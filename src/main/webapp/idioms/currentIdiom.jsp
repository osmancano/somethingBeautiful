<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<br/>
<style>
    .alert-message
    {
        margin: 20px 0;
        padding: 20px;
        border-left: 3px solid #eee;
    }
    .alert-message h4
    {
        margin-top: 0;
        margin-bottom: 5px;
    }
    .alert-message p:last-child
    {
        margin-bottom: 0;
    }
    .alert-message code
    {
        background-color: #fff;
        border-radius: 3px;
    }
    .alert-message-success
    {
        background-color: #F4FDF0;
        border-color: #3C763D;
    }
    .alert-message-success h4
    {
        color: #3C763D;
    }
    .alert-message-danger
    {
        background-color: #fdf7f7;
        border-color: #d9534f;
    }
    .alert-message-danger h4
    {
        color: #d9534f;
    }
    .alert-message-warning
    {
        background-color: #fcf8f2;
        border-color: #f0ad4e;
    }
    .alert-message-warning h4
    {
        color: #f0ad4e;
    }
    .alert-message-info
    {
        background-color: #f4f8fa;
        border-color: #5bc0de;
    }
    .alert-message-info h4
    {
        color: #5bc0de;
    }
    .alert-message-default
    {
        background-color: #EEE;
        border-color: #B4B4B4;
    }
    .alert-message-default h4
    {
        color: #000;
    }
    .alert-message-notice
    {
        background-color: #FCFCDD;
        border-color: #BDBD89;
    }
    .alert-message-notice h4
    {
        color: #444;
    }
    .clickable
    {
        cursor: pointer;
    }

    .clickable .glyphicon
    {
        background: rgba(0, 0, 0, 0.15);
        display: inline-block;
        padding: 6px 12px;
        border-radius: 4px
    }

    .panel-heading span
    {
        margin-top: -23px;
        font-size: 15px;
        margin-right: -9px;
    }
    a.clickable { color: inherit; }
    a.clickable:hover { text-decoration:none; }
</style>
<script>
    $( document ).ready(function() {
        $('#addComment').click(function(event) {
            event.preventDefault();
            $.post($(this).attr('href'),{comment : $("#idiomComment").val(), idiomId: $("#idiomID").val()},function(response){
                //$('#mainDiv').html(response); // update the DIV
                location.reload();
            });
            return false; // cancel original event to prevent form submitting
        });

        $('Select').change(function() {
            var myForm = $(this).closest('form');
            $.get(myForm.attr('action'),myForm.serialize(),function (response) {
                $("#mainDiv").html(response);
            })
        });

        $('.getIdioms').click(function (event) {
            event.preventDefault();
            $.ajax({ // create an AJAX call...
                type: 'GET', // GET or POST
                url: $(this).attr('href'), // the file to call
                success: function(response) { // on success..
                    $('#mainDiv').html(response);
                }
            });
            return false;
        });
    });
</script>
<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">
             Idioms
        </h3>
        <span class="pull-right">
       <i></i>
        </span>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-3 col-xs-3" >
                <c:if test="${idioms.hasPrevious()}">
                    <div class="pull-left">
                        <a class="getIdioms btn btn-sm btn-primary" href="/idioms?page=<c:out value="${idioms.number - 1}"/>">
                            Previous Idiom
                        </a>
                    </div>
                </c:if>
            </div>

            <div class="col-sm-6 col-xs-6">
            </div>

            <div class="col-sm-3 col-xs-3">

                <c:if test="${idioms.hasNext()}">
                    <div class="pull-right">
                        <a class="getIdioms btn btn-sm btn-primary" href="/idioms?page=<c:out value="${idioms.number + 1}"/>">
                            Next Idiom
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
        <c:forEach items="${idioms.iterator()}" var="idiom">
        <div class="col-sm-10 col-md-10">
            <div class="alert-message alert-message-info">
            <h2 style="color:brown">
                <c:out value="${idiom.idiomText}"/>
            </h2>
                <input type="hidden" id="idiomID" name="idiomId" value="${idiom.id}">
        </div>
            <div>
                <h3>Comments:</h3>
                <c:forEach items="${idiom.comments}" var="comment">
                    <div class="media">
                        <div class="media-left media-top">
                            <c:if test="${comment.user.userImageFile!=null}">
                                <img src="/ourCoolUploadedFiles/<c:out value="${comment.user.userImageFile}"/>" class="media-object img-circle" style="width:50px">
                            </c:if>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading"><c:out value="${comment.user.username}"/> <small><i><c:out value="${comment.commentDate}"/></i></small></h4>
                            <p><c:out value="${comment.comment}"/>.</p>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
    </c:forEach>
    </div>
</div>
    <c:if test="${user!=null}">
    <div class="col-sm-6">
        <br>
            <div class="form-group">
                <label for="idiomComment">Comment:</label>
                <textarea class="form-control" id="idiomComment" name="comment"></textarea>
            </div>
            <a id="addComment" href="/idioms/addComment" class="btn btn-primary">Add Comment</a>
    </div>
    </c:if>
