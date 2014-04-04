<#import "header.ftl" as header/>
<@header.header/>
<@header.navbarStart/>
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
                <div class="help-container">
                    <div id="startHelp" class="start-help help">
                        <span class="glyphicon glyphicon-arrow-up"></span><br/>Select a draft to start
                    </div>
                </div>
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
<@header.navbarEnd/>
<div id="wrap">
    <div class="container clear-top cards-container" id="cardsContainer">

    </div>
</div>

    <script>
        var activeData = null;
        var stringData = null;
        var highlightedPlayer = 1;
        var startHelpNeeded = true;
        var cardWidth = 120;
        $(document).ready(function() {
            setTimeout(function() {
                if (startHelpNeeded) {
                    $("#startHelp").show().animate({top: "-=20", opacity: 1})
                }
            }, 3000);
            $("#draftSelector a").click(function() {
                startHelpNeeded = false;
                $("#startHelp").hide();
                var id = $(this).data("id");
                $.ajax({
                    type: "GET",
                    url: "/loadSavedDraft",
                    data: {
                        draftId: id
                    },
                    success: function(data) {
                        $("#startHelp").hide();
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
            $container.css("width", cardWidth*8+"px");
            for (var j=0; j<15; j++) {
                player = 1;
                var $div = $container.append("<div></div>");
                for (var i=0; i<8; i++) {
                    var cardPos = (i+offset)%8;
                    var tooltipText = 'Player '+(cardPos+1)+'<br/>Pick '+(j+1)+'';
                    $div.append("<img  data-player='"+(cardPos+1)+"' data-toggle='tooltip' title='"+tooltipText+"' class='pick"+(j+1)+" player"+(cardPos+1)+"' style='width:"+cardWidth+"px;' src='"+pack[(cardPos+j*8)]+"'/>");
                }
                offset++;
            }
            var $cards = $container.find("img");
            $cards.tooltip({placement: "top", html: true});
            $cards.click(function() {
                // highlight player that picked this card
                highlightedPlayer = $(this).data("player");
                highlightSelectedPlayer();
            });
        }
    </script>

<#include "footer.ftl">
