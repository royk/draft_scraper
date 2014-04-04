<#include "header.ftl">
        <ul class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    Show Draft
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu" id="draftSelector">
                    <li>
                        <a href="#" data-id="0">Pro Tour Theros, Draft 1 Pod 33, Triple Theros (Oct 2013)</a>
                    </li>
                    <li>
                        <a href="#" data-id="1">Pro Tour Born of the gods, Draft 2, Pod 5, BTT (Feb 2014)</a>
                    </li>
                </ul>
            </li>
            <li class="dropdown draft-control" id="packChooser">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                   <span>Pack 1</span>
                   <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <#assign x=2>
                    <#list 0..x as i>
                        <li>
                            <a data-id="${i}">Pack ${i+1}</a>
                        </li>
                    </#list>
                </ul>
            </li>
            <li class="dropdown draft-control" id="playerChooser">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span>Player 1</span>
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                <#assign x=1>
                <#list 1..8 as i>
                    <li>
                        <a data-id="${i}">Player ${i}</a>
                    </li>
                </#list>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div id="wrap">
    <div class="container clear-top cards-container" id="cardsContainer">

    </div>
</div>
    <script>
        var activeData = null;
        var stringData = null;
        var highlightedPlayer = 1;
        $(document).ready(function() {
            $("#draftSelector a").click(function() {
                var id = $(this).data("id");
                $.ajax({
                    type: "GET",
                    url: "/loadSavedDraft",
                    data: {
                        draftId: id
                    },
                    success: function(data) {
                        stringData = data;
                        data = JSON.parse(data);
                        activeData = data.picks.data;
                        $(".draft-control").show();
                        loadPackData(activeData[0]);
                        highlightSelectedPlayer();
                    }
                });
            });
            // draft controls
            $("#packChooser .dropdown-menu a").click(function() {
                var packNumber = parseInt($(this).data("id"));
                $("#packChooser > a > span").text("Pack "+(packNumber+1));
                loadPackData(activeData[packNumber]);
                highlightSelectedPlayer();
            });
            $("#playerChooser .dropdown-menu a").click(function() {
                highlightedPlayer = parseInt($(this).data("id"));

                highlightSelectedPlayer();
            });
        });
        function highlightSelectedPlayer() {
            $("#playerChooser > a > span").text("Player "+highlightedPlayer);
            $("#cardsContainer img").removeClass("highlight");
            $(".player"+highlightedPlayer).addClass("highlight");
        }
        function loadPackData(pack) {
            var offset = 0;
            var $container = $("#cardsContainer");
            $container.html("");
            for (var j=0; j<15; j++) {
                player = 1;
                var $div = $container.append("<div></div>");
                for (var i=0; i<8; i++) {
                    var cardPos = (i+offset)%8;
                    $div.append("<img  data-player='"+(cardPos+1)+"' class='pick"+(j+1)+" player"+(cardPos+1)+"' style='width:120px;' src='"+pack[(cardPos+j*8)]+"'/>");
                }
                offset++;
            }
            $container.find("img").click(function() {
                // highlight player that picked this card
                highlightedPlayer = $(this).data("player");
                highlightSelectedPlayer();
            });
        }
    </script>

<#include "footer.ftl">
