App.DraftViewController = Ember.ObjectController.extend({
    dataSetter: function() {
        var packs = this.get("picks.data");
        var players = [];
        var boosters = [];
        var cards = [];
        App.Booster = Ember.Object.extend({});
        App.Player = Ember.Object.extend({});
        App.Card = Ember.Object.extend({});
        for (var playerNum=0; playerNum<8; playerNum++) {
            var player = App.Player.create();
            player.set("name", this.get("players")[playerNum]);
            player.set("picks", []);
            players.push(player);

        }
        for (var boosterNum=0; boosterNum<24; boosterNum++) {
            var booster = App.Booster.create();
            booster.set("picks", []);
            boosters.push(booster);
        }
        for (var currentPack=0; currentPack<packs.length; currentPack++) {
            var boosterNum;
            for (var pickNum=0; pickNum<15; pickNum++) {
                for (var playerNum=0; playerNum<8; playerNum++) {
                    var card = App.Card.create();
                    card.set("src", packs[currentPack][playerNum+pickNum*8]);
                    card.set("player",  players[playerNum]);
                    card.set("pick", pickNum);
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
                }
            }
        }
        this.set("boosters", boosters);
        this.set("playersData", players);
    }.observes("picks"),
    boosters: null,
    playersData: null
});