App.DraftViewController = Ember.ObjectController.extend({
    needs: ["application"],
    dataSetter: function() {
        var packs = this.get("picks.data");
        var players = [];
        var boosters = [];
        var cards = [];
        var packsData = [];
        App.Booster = Ember.Object.extend({});
        App.Player = Ember.Object.extend({});
        App.Card = Ember.Object.extend({});
        App.Pack = Ember.Object.extend({});
        for (var playerNum=0; playerNum<8; playerNum++) {
            var player = App.Player.create();
            player.set("name", this.get("players")[playerNum]);
            player.set("picks", []);
            players.push(player);

        }
        for (var boosterNum=0; boosterNum<24; boosterNum++) {
            var booster = App.Booster.create();
            booster.set("picks", []);
            booster.set("number", (boosterNum%8)+1);
            if (boosterNum===0 || boosterNum===8 || boosterNum===16) {
                booster.set("packNumber", boosterNum/8+1);
            }
            boosters.push(booster);
        }
        for (var currentPack=0; currentPack<packs.length; currentPack++) {
            var pack = App.Pack.create();
            pack.set("cards", [120]);
            pack.set("number", currentPack+1);
            packsData.push(pack);

            var boosterNum;
            for (var pickNum=0; pickNum<15; pickNum++) {
                for (var playerNum=0; playerNum<8; playerNum++) {
                    var card = App.Card.create();
                    card.set("src", packs[currentPack][playerNum+pickNum*8]);
                    card.set("player",  players[playerNum]);
                    card.set("playerClass",  "player"+playerNum);
                    card.set("playerNum",  playerNum);
                    card.set("pick", pickNum+1);
                    card.set("pack", currentPack);

                    if (currentPack===1) {
                        boosterNum = (playerNum+pickNum)%8;
                    } else {
                        boosterNum = (playerNum-pickNum)%8;
                    }
                    if (boosterNum<0) {
                        boosterNum = 8-Math.abs(boosterNum);
                    }
                    boosterNum = boosterNum+currentPack*8;
                    card.set("booster", boosters[boosterNum]);
                    boosters[boosterNum].get("picks").push(card);
                    players[playerNum].get("picks").push(card);
                    card.set("title", card.get("player.name")+"<br/>Pick "+card.get("pick"));
                    cards.push(card);
                    pack.get("cards")[(boosterNum%8)+pickNum*8] = card;
                }
            }
        }
        this.set("boosters", boosters);
        this.set("playersData", players);
        this.set("cards", cards);
        this.set("packs", packsData);
    }.observes("picks"),
    boosters: null,
    cards: null,
    playersData: null,
    packs: null,
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
    }.observes("controllers.application.boosterView", "picks"),
    actions: {
        cardSelected: function(card) {
            $(".card-container .card").removeClass("highlight");
            $(".card-container ."+card.get("playerClass")).addClass("highlight");
        }
    }

});