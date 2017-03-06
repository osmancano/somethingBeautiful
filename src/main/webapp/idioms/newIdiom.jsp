<script>
    $('#newIdiom').submit(function() { // catch the form's submit event
        event.preventDefault();
        var form = $('#newIdiom')[0];
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
            <h4 class="modal-title">Add New Idiom</h4>
        </div>
        <div class="modal-body">
            <form id="newIdiom" enctype="multipart/form-data" class="form-horizontal" action="/idioms/addIdiom" method="post">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="idiomText">IdiomText:</label>
                    <div class="col-sm-9">
                        <textarea class="form-control" id="idiomText" name="idiomText" required></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-10">
                        <button type="submit" class="btn btn-info">Add</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>