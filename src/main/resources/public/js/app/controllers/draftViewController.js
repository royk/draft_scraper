App.DraftViewController = App.DraftAnalyzerControllerBase.extend({
    needs: ["application"],
    playerPicksOrdered: function() {
        // sort players picks for the player view display (row x is players' x pick)
        var cards = [];
        var players = this.get("playersData");
        for (var currentPack=0; currentPack<3; currentPack++) {
            for (var pickNum=0; pickNum<15; pickNum++) {
                for (var playerNum=0; playerNum<8; playerNum++) {
                    cards.push(players[playerNum].get("picks")[15*currentPack+pickNum]);
                }
            }
        }
        return cards;
    }.property("playersData"),
    animateCards: function() {
        Ember.run.scheduleOnce('afterRender', this, function() {
            $("img").tooltip({placement: "top", html: true}).mouseover(function() {
                // Has to happen outside execution scope because tooltip won't exist yet.
                setTimeout(function() {
                    var $tooltip = $(".tooltip");
                    if (!$tooltip.is(":animated")) {
                        var moveUp = 200/8;
                        $tooltip.animate({top: "-="+moveUp}, 200);
                    }
                }, 0);
            });
        });
    },
    onModeChange: function() {
        this.animateCards();
    }.observes("controllers.application.viewModeChanged", "picks"),
    init: function() {
        this.get("controllers.application").set("startHelpNeeded", false);
    },
    actions: {
        cardSelected: function(card) {
            $(".card-container .card").removeClass("highlight");
            $(".card-container ."+card.get("playerClass")).addClass("highlight");
        }
    }

});