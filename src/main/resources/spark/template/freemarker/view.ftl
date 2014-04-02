<style>
    .player1 {
        border: red 5px solid;
        box-sizing: border-box;
    }

</style>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
    var output = ${output};

    var pack1 = output.picks.data[0];
    $(document).ready(function() {
        var offset = 0;
        for (var j=0; j<15; j++) {
            player = 1;
            var $div = $("body").append("<div></div>");
            for (var i=0; i<8; i++) {
                var cardPos = (i+offset)%8;
                $div.append("<img  class='pick"+(j+1)+" player"+(cardPos+1)+"' style='width:150px;' src='"+output.picks.data[0][(cardPos+j*8)]+"'/>");
            }
            offset++;
        }
    });
</script>