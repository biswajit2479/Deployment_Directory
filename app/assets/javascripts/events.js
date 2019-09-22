var format = 'YYYY-MM-DD';
$(function () {
    $('#startDatePicker').datetimepicker({
        format: format
    });
});
$(function () {
    $('#endDatePicker').datetimepicker({
        format: format
    });
});

$(function () {
    $('#DateSearch').datetimepicker({
        format: format
    });
});

