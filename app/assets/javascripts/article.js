if( $('.edit-history').length ) {
    $(function() {

        hide_edit_history();

        $('.edit-history').on('click', function(){
            console.log("hi")
            if ($('.edit-history').prop('checked')) {
                hide_edit_history();
            } else {
                show_edit_history();
            }
        })
    });

    this.hide_edit_history = function() {
        $('edit-history-content').hide()
    }

    this.show_edit_history = function () {
        $('edit-history-content').show()
    }
}