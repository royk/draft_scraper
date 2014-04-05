<#import "header.ftl" as header/>
<@header.header/>
<@header.navbarStart/>
<@header.navbarEnd/>
<div class="container">
    <div class="row span12 draftControls" id="loadDraftControls">
        <label>Draft Viewer URL: <input id="scrapeDraftURL" type="text" placeholder="e.g. http://gatherer.wizards.com/magic/draftools/draftviewer.asp?draftid=08_01_2013_1"></label>
        <button class="btn btn-lg btn-primary" id="scrapeDraftBtn">Scrape!</button>
        <div>
            (note, this may take a few minutes)
        </div>
    </div>
    <div class="row span12 draftControls" id="showDraftControls">
        <label> Show pack:
            <select id="packChooser">
                <#assign x=2>
                <#list 0..x as i>
                    <option value="${i}">Pack ${i+1}</option>
                </#list>
            </select>
        </label>
        <label> Highlight player:
            <select id="playerChooser">
                <#assign x=1>
                <#list 1..8 as i>
                    <option value="${i}">Player ${i}</option>
                </#list>
            </select>
        </label>
    </div>
</div>

<div class="container" id="cardsContainer">

</div>

<script>
    var activeData = null;
    var stringData = null;
    $(document).ready(function() {
        // draft controls
        $("#packChooser").change(function() {
            loadPackData(activeData[parseInt($(this).val(), 10)]);
            highlightSelectedPlayer();
        });
        $("#playerChooser").change(function() {
            highlightSelectedPlayer();
        });
        $("#scrapeDraftBtn").click(function() {
            $.ajax({
                type: "GET",
                url: "/scrape",
                data: {
                    url: $("#scrapeDraftURL").val()
                },
                success: function(data) {
                    stringData = data;
                    data = JSON.parse(data);
                    activeData = data.picks.data;
                    $("#loadDraftControls").hide();
                    $("#showDraftControls").show();
                    loadPackData(activeData[0]);
                    highlightSelectedPlayer();
                }
            });
        })
    });
    function highlightSelectedPlayer() {
        var playerNumber = parseInt($("#playerChooser").val(), 10)
        $("#cardsContainer img").removeClass("highlight");
        $(".player"+playerNumber).addClass("highlight");
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
                $div.append("<img  class='pick"+(j+1)+" player"+(cardPos+1)+"' style='width:120px;' src='"+pack[(cardPos+j*8)]+"'/>");
            }
            offset++;
        }
    }
</script>
<#include "footer.ftl">

