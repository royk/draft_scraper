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
                        <a href="#" data-id="10">2014 World Championship, Vintage Masters Draft, Pod 2 (Dec 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="9">2014 World Championship, Khans of Tarkir, Pod 1 (Dec 2014)</a>
                    </li>

                    <li>
                        <a href="#" data-id="8">Pro Tour Khans of Tarkir, Draft 2, Pod 1 (Oct 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="7">Pro Tour Khans of Tarkir, Draft 1, Pod 19 (Oct 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="6">Pro Tour Magic 2015, Draft 1, Pod 9, M15 (Aug 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="4">Pro Tour Journey Into Nyx, Draft 1 Pod 4, JBT (May 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="5">Pro Tour Journey Into Nyx, Draft 2 Pod 1, JBT (May 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="2">MOCS 2013, Pod 1, BTT (March 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="3">MOCS 2013, Pod 2, BTT (March 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="1">Pro Tour Born of the gods, Draft 2, Pod 5, BTT (Feb 2014)</a>
                    </li>
                    <li>
                        <a href="#" data-id="0">Pro Tour Theros, Draft 1 Pod 33, Triple Theros (Oct 2013)</a>
                    </li>
                </ul>
                <div class="help-container">
                    <div id="startHelp" class="start-help help floating-help">
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
                    <li>
                        <a data-id="all">All packs</a>
                    </li>
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
            <li class="draft-control">
                <a class="player-seen-only" href="#" id="playerSeenOnly" title="<div style='width:150px;text-align:center;'>Hide cards not seen<br/> by selected player</div>" data-toggle="tooltip">
                    <span class="glyphicon glyphicon-eye-open" />
                </a>
                <a class="player-seen-only" href="#" id="removePlayerSeenOnly" title="<div style='width:100px;text-align:center;'>Show all cards</div>" data-toggle="tooltip" style="display:none;">
                    <span class="glyphicon glyphicon-eye-close" />
                </a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right draft-control">
            <li><a href="#" id="helpButton"><span class="glyphicon glyphicon-question-sign"></span></a></li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span></a>
                <ul class="dropdown-menu settings-menu">
                    <li>
                        Cards Size<br/>
                        <div style="margin-left: 5px;">
                            <label><input type="radio" name="cardSize" value="80"/>Small</label>
                            <label><input type="radio" name="cardSize" value="120"/>Normal</label>
                            <label><input type="radio" name="cardSize" value="160"/>Large</label>
                        </div>
                    </li>
                    <li>
                        <label><input type="checkbox" id="showTooltipCB">Tooltips</label>
                    </li>
                </ul>
            </li>
        </ul>
<@header.navbarEnd/>
<div id="wrap">
    <div class="container help help-tutorial" id="helpSectionContainer" style="position: relative;">
        <div style="position: absolute;">
            <div id="helpSection1" class="help-section">
                Each column below represents a pack opened by a certain player.
                The <a href="#" data-column="1" class="column-highlight-button">first column</a> shows all the cards in the pack opened by the first player.
                The <a href="#" data-column="2" class="column-highlight-button">second column</a> is the pack opened by the second player, etc.
            </div>
            <div id="helpSection2" class="help-section">
                Cards are sorted by their pick number. For example, the <a href="#" class="card-highlight-button" data-card="0">top card of the first column</a>
                is the first player's first pick.
            </div>
            <div id="helpSection3" class="help-section">
                After each pick, the player's next pick will be down one spot, left one spot. For example, the <a href="#" class="card-highlight-button" data-card="9">third player's second pick</a>
                is right below the second player's first pick. (i.e., the second card on the second pack's column).
            </div>
            <div id="helpSection4" class="help-section">
                Below each pick are the cards that were in the pack when the player made their pick. So for each pick,
                you get to see exactly what were the options that were available to the player.
            </div>
            <div id="helpSection5" class="help-section">
                In the menu above, you can change the shown pack or the highlighted player. Alternatively, you can
                simply click on a card to highlight all the picks of the player who picked it.
            </div>
            <div style="margin-top:20px;">
                <a href="#" id="helpNextButton" >Next <span class="glyphicon glyphicon-play"></span></span></a>
            </div>
        </div>
    </div>
    <div class="container url-container">fwefwe</div>
    <div class="container clear-top cards-container" id="cardsContainer">

    </div>
</div>

    <script>
        (function() {
            var activePlayers = null;
            var activeUrl = "";
            var activeData = null;
            var stringData = null;
            var highlightedPlayer = 1;
            var startHelpNeeded = true;
            var cardWidth = localStorage.getItem('cardWidth') || 120;
            var currentHelpSection = 0;
            var activePackNumber = 0;
            var showAllPacks = false;
            var activeDraftTitle = "";
            var hideUnseen = false;
            var showTooltips = localStorage.getItem('showTooltips')==undefined ? true : localStorage.getItem('showTooltips')=="true";
            $("#playerSeenOnly, #removePlayerSeenOnly").tooltip({placement: "bottom", html: true});
            $("#playerSeenOnly").click(function() {
                $(this).hide();
                $("#removePlayerSeenOnly").show();
                hideUnseen = true;

                setHighlightedPlayer(highlightedPlayer);
            });
            $("#removePlayerSeenOnly").click(function() {
                $(this).hide();
                $("#playerSeenOnly").show();
                hideUnseen = false;
                setHighlightedPlayer(highlightedPlayer);
            });
            $(document).ready(function() {
                var preloadDraftId = getURLParameter("draft_id");
                if (preloadDraftId) {
                    startHelpNeeded = false;
                    loadSavedDraft(parseInt(preloadDraftId, 10));
                }
                setTimeout(function() {
                    if (startHelpNeeded) {
                        $("#startHelp").show().animate({top: "-=20", opacity: 1})
                    }
                }, 3000);
                $("input[name=cardSize]").filter("[value="+cardWidth+"]").prop("checked", true);
                $("input[name=cardSize]").change(function() {
                    cardWidth = $(this).val();
                    localStorage.setItem('cardWidth', cardWidth);
                    loadPackData();
                });
                $("#showTooltipCB").attr("checked", showTooltips);
                $("#showTooltipCB").change(function() {
                    showTooltips = $(this).is(":checked");
                    localStorage.setItem('showTooltips', showTooltips);
                    loadPackData();
                });
                $("#helpButton").click(function() {
                    if (currentHelpSection!==0) {
                        currentHelpSection = 0;
                        $("#helpSectionContainer").hide().css("opacity", "0");
                        return;
                    }
                    showNextHelpSection();
                    $("#helpSectionContainer").show().animate({opacity:1});
                });
                $("#helpNextButton").click(function() {
                    showNextHelpSection();
                });

                function showNextHelpSection() {
                    currentHelpSection++;
                    $(".help-section").hide();
                    var nextSection = $("#helpSection"+currentHelpSection);
                    if (nextSection.length) {
                        $("#helpSection"+currentHelpSection).show();
                    } else {
                        currentHelpSection = 0;
                        $("#helpSectionContainer").hide().css("opacity", "0");
                    }
                }

                $(".column-highlight-button").hover(function() {
                    var column = $(this).data("column");
                    $("#cardsContainer img").removeClass("highlight");
                    $("#cardsContainer img.column"+column).addClass("highlight");
                });
                $(".card-highlight-button").hover(function() {
                    var card = $(this).data("card");
                    $("#cardsContainer img").removeClass("highlight");
                    $("#cardsContainer img.card"+card).addClass("highlight");
                });



                $("#draftSelector a").click(function() {
                    loadSavedDraft($(this).data("id"));
                });
                // draft controls
                $("#packChooser .dropdown-menu a").click(function() {
                    var id = $(this).data("id");
                    showAllPacks = id==="all";
                    if (!showAllPacks) {
                        activePackNumber = parseInt(id);
                    }
                    loadPackData();
                    setHighlightedPlayer(highlightedPlayer);
                });
                $("#playerChooser .dropdown-menu a").click(function() {
                    setHighlightedPlayer(parseInt($(this).data("id")));
                });
            });

            function getURLParameter(name) {
                return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
            }

            function loadSavedDraft(id) {
                activeDraftTitle = $(this).text();
                startHelpNeeded = false;
                $("#startHelp").hide();
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
                        activePlayers = data.players;
                        activeUrl = data.url;
                        $(".cards-container").removeClass("minimal-margin");
                        if (activeUrl) {
                            $(".url-container").html("<a href='"+activeUrl+"' target='_blank'>Draft Viewer on Gatherer</a>");
                            $(".url-container").show();
                            $(".cards-container").addClass("minimal-margin");
                        } else {
                            $(".url-container").hide();
                        }
                        $(".draft-control").show();
                        activePackNumber = 0;
                        loadPackData();
                        highlightSelectedPlayer();
                    }
                });
            }

            function getPlayerName(playerIndex) {
                if (activePlayers) {
                    return activePlayers[playerIndex];
                }
                return "Player "+playerIndex;
            }

            function hideUnseenByPlayer() {
                $(".pack").each(function() {
                    var $this = $(this);
                    for (var i=1; i<9; i++) {
                        var seen = false;
                        $this.find(".column"+i).each(function() {
                            if (!seen && parseInt($(this).data("player"),10) ===highlightedPlayer) {
                                seen = true;
                            }
                            $(this).css("visibility", seen ? "visible" : "hidden");
                        });
                    }
                });
            }

            function setHighlightedPlayer(player) {
                highlightedPlayer = player;
                $(".card").css("visibility", "visible");
                if (hideUnseen) {
                    hideUnseenByPlayer();
                }
                highlightSelectedPlayer();
            }
            function highlightSelectedPlayer() {
                $("#playerChooser > a > span").text("Player "+highlightedPlayer);
                $("#cardsContainer img").removeClass("highlight");
                $(".player"+highlightedPlayer).addClass("highlight");
            }
            function loadPackData() {
                var $container = $("#cardsContainer");
                $container.html("");
                $container.css("width", cardWidth*8+"px");

                $container.append("<h3 style='text-align:center; margin-bottom: 20px;'>"+activeDraftTitle+"</h3>");
                if (showAllPacks) {
                    for (activePackNumber=0; activePackNumber<3; activePackNumber++) {
                        loadSinglePack(activePackNumber);

                    }
                } else {
                    loadSinglePack(activePackNumber);
                }
                var $cards = $container.find("img");
                if (showTooltips) {
                    $cards.tooltip({placement: "top", html: true});
                }
                $cards.click(function() {
                    // highlight player that picked this card
                    setHighlightedPlayer($(this).data("player"));
                });
            }
            function loadSinglePack(packNumber) {
                var $container = $("#cardsContainer");
                var cardHeight = Math.floor(cardWidth / 0.7017543859649123);
                if (!showAllPacks) {
                    $("#packChooser > a > span").text("Pack "+(packNumber+1));
                } else {
                    $("#packChooser > a > span").text("All packs");
                }
                var pack = activeData[packNumber];
                var offset = 0;
                var $packDiv = $("<div class='pack pack"+(packNumber+1)+"'></div>")
                var card = 0;
                for (var j=0; j<15; j++) {
                    var player = 1;
                    for (var i=0; i<8; i++) {
                        var currentPlayer = (i+offset)%8;
                        if (packNumber==1) {
                            currentPlayer = (i-offset)%8;
                            if (currentPlayer<0) currentPlayer+=8;
                        }
                        var tooltipText = showTooltips? getPlayerName(currentPlayer)+'<br/>Pick '+(j+1)+'' : "";
                        var cardUrl = pack[(currentPlayer+j*8)];
                        var cardName = cardUrl.split("/");
                        cardName = cardName[cardName.length-1];
                        cardName = cardName.split(".")[0];
                        cardName = cardName.replace(/_/gi, " ");
                        var $card = $("<img alt='"+cardName+"'data-player='"+(currentPlayer+1)+"' data-toggle='tooltip' title='"+tooltipText+"' class='card card"+card+" column"+(i+1)+" pick"+(j+1)+" player"+(currentPlayer+1)+"' style='width:"+cardWidth+"px;height:"+cardHeight+";' src='"+pack[(currentPlayer+j*8)]+"'/>");
                        $packDiv.append($card);
                        card++;
                    }
                    offset++;
                }
                $container.append($packDiv);
                $container.append("<div style='margin:50px 0;'></div>");
                // Move the tooltip up a bit so it doesn't obstruct the card name when the card is scaled.
                $(".card").mouseover(function() {
                    // Has to happen outside execution scope because tooltip won't exist yet.
                    setTimeout(function() {
                        var $tooltip = $(".tooltip");
                        if (!$tooltip.is(":animated")) {
                            var moveUp = cardWidth/8;
                            $tooltip.animate({top: "-="+moveUp}, 200);
                        }
                    }, 0);
                });
            }
        })();
    </script>

<#include "footer.ftl">
