<script>
    $('#signInForm').submit(function() { // catch the form's submit event
        event.preventDefault();
        var form = $('#signInForm')[0];
        var data = new FormData(form);
        $.ajax({ // create an AJAX call...
            enctype: 'multipart/form-data',
            type: $(this).attr('method'), // GET or POST
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            url: $(this).attr('action'), // the file to call
            success: function(response) { // on success..
                $("#ModalDiv").modal("toggle");
                //$('#resultDiv').html(response); // update the DIV
                location.reload();
            }
        });
        return false; // cancel original event to prevent form submitting
    });
</script>
<div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Sign In</h4>
        </div>
        <div class="modal-body">
            <form id="signInForm" enctype="multipart/form-data" class="form-horizontal" action="/idoims/users/signin" method="post">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="username">Username:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="password">Password:</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-10">
                        <button type="submit" class="btn btn-info">Sign In</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>