<script src="http://code.jquery.com/jquery.js"></script>
<script>
    var output = ${output};
    var pack1 = output.picks.data[0];
    $(document).ready(function() {
        for (var i=0; i<8; i++) {
            $("body").append("<img src='"+output.picks.data[0][i]+"'/>");
        }
    });
</script>