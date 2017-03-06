<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chat App</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            background-color: #006699;
            margin-bottom: 0;
            border-radius: 0;
        }
        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {height: 450px}
        /* Set gray background color and 100% height */
        .sidenav {
            padding-top: 20px;
            height: 100%;
        }
        /* Set black background color, white text and some padding */
        footer {
            background-color: #006699;
            color: white;
            padding: 15px;
        }
        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 767px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }
            .row.content {height:auto;}
        }
    </style>
    <script>
        $( document ).ready(function() {
            $('#mainDiv').load("/idioms");

            $("#btnSignUp").click(function(event) {
                event.preventDefault();
                $("#ModalDiv").load("newUser.html");
                $("#ModalDiv").modal("show");
            });
            $("#btnSignIn").click(function(event) {
                event.preventDefault();
                $("#ModalDiv").load("login.jsp");
                $("#ModalDiv").modal("show");
            });
            $("#btnAddIdiom").click(function(event) {
                event.preventDefault();
                $("#ModalDiv").load("newIdiom.jsp");
                $("#ModalDiv").modal("show");
            });
        });
    </script>
</head>
<body>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="col-sm-4">
        <h2 class="muted" style="color:brown">Idioms</h2>
    </div>
</div>
<nav class="navbar navbar-inverse fixed">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"></a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li></li>
                <li>
                    <a href="/" id="btnBoards" class="btn btn-sm btn-primary">
                        <span class="glyphicon glyphicon-home"></span> Home
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${user!=null}">
                    <li><a>Welcome &nbsp;<span class="badge"><c:out value="${user.username}"/></span></a></li>
                    <li><a href="/idioms/users/signout"><span class="glyphicon glyphicon-log-out"></span>Sign out</a></li>
                </c:if>
                <c:if test="${user==null}">
                    <li><a id="btnSignIn" href="">Sign in</a></li>
                    <li><a id="btnSignUp" href="">Sign up</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid text-left">
    <div class="row content">
        <div class="col-sm-1">
            <br>
            <div id="resultDiv"></div>
            <c:if test="${user!=null && user.username == 'admin'}">
            <a id="btnAddIdiom" href="" class="btn btn-sm btn-primary">Add New Idiom</a>
            </c:if>

        </div>
        <div class="col-sm-9 text-left" id="mainDiv">
        </div>
        <div class="col-sm-1">
            <hr>
            <c:if test="${user.userImageFile!=null}">
                <img class="card-img-top" width="100" src="/ourCoolUploadedFiles/<c:out value="${user.userImageFile}"/>" alt="Card image cap">
            </c:if>
            <h4>
                <c:out value="${user.username}"/>
            </h4>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="ModalDiv" role="dialog">

    </div>
</div>

</body>
</html>