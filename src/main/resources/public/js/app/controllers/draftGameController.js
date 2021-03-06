App.DraftGameController = App.DraftAnalyzerControllerBase.extend({
    currentPick: 0,
    selectedBooster: null,
    selectedBoosterNum: -1,
    playedBoosters: [],
    pickedCards: [],
    selectedBoosterShuffledPicks: [],
    score: 0,
    correctGuesses: 0,
    pointsPerPick: [10, 14, 14, 12, 12, 10, 10, 8, 8, 6, 6, 4, 4, 2, 0],
    isGameOver: false,
    pickStatsData: [],
    getCardPickPercentage: function(pick, card) {
        function round(value, exp) {
            if (typeof exp === 'undefined' || +exp === 0)
                return Math.round(value);

            value = +value;
            exp  = +exp;

            if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0))
                return NaN;

            // Shift
            value = value.toString().split('e');
            value = Math.round(+(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp)));

            // Shift back
            value = value.toString().split('e');
            return +(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp));
        }
        var data = this.get("pickStatsData");
        if (data && data.hasOwnProperty(pick) && data[pick].hasOwnProperty(card.dbKey)) {
            data = data[pick];
            var totalPicks = 0;
            for (var k in data) {
                if (data.hasOwnProperty(k)) {
                    totalPicks += data[k];
                }
            }
            return round((data[card.dbKey]/totalPicks)*100, 2);
        }
        return 0;
    },
    onDraftChanged: function() {
        var id = this.get("id");
        if (id) {
            $.ajax({
                url: "/getStatistics?draftId="+this.get("id"),
                type: "GET",
                success: (function(data) {
                    if (data) {
                        try {
                            this.set("pickStatsData", JSON.parse(data));
                        } catch(e) {

                        }
                    }
                }).bind(this)
            });
        }

    }.observes("id"),
    selectedBoosterShuffled: function() {
        var picks = this.get("selectedBooster.picks");
        var shuffledBooster = [];
        if (picks) {
            var indexesLeft = [];
            for (var i=0; i<picks.length; i++) {
                indexesLeft.push(i);
            }
            while(indexesLeft.length) {
                var randIndex = Math.floor(Math.random()*(indexesLeft.length));
                var index = indexesLeft.splice(randIndex, 1)[0];
                shuffledBooster.push(picks[index]);
            }
        }
        this.set("selectedBoosterShuffledPicks", shuffledBooster);
    }.observes("selectedBooster"),
    onContentChanged: function() {
        Ember.run.scheduleOnce('afterRender', this, function() {
            this.set("playedBoosters", []);
            this.send("startGame");
        });
    }.observes("picks"),
    getModalHeader: function(guessedCorrectly) {
        if (guessedCorrectly) {
            return "Correct pick!"
        } else {
            return "Sorry, you guessed wrong :(";
        }
    },
    modalHeader: "",
    selectedCard: null,
    guessedCard: null,
    pickPercentage: 0,
    actions: {
        startGame: function() {
            this.set("isGameOver", false);
            this.set("currentPick", 0);
            this.set("score", 0);
            this.set("correctGuesses", 0);
            this.set("pickedCards", []);
            // pick a pack one booster randomly. Make sure it's not one we already played
            var playedBoosters = this.get("playedBoosters").slice();
            var boosterNum = 0;
            var found = true;
            do {
                found = true;
                boosterNum = Math.floor(Math.random()*8);
                for (var i=0; i<playedBoosters.length; i++) {
                    if (playedBoosters[i]===boosterNum) {
                        found = false;
                        break;
                    }
                }

            } while(found===false);
            playedBoosters.push(boosterNum);
            if (playedBoosters.length===8) {
                playedBoosters = [];
            }
            this.set("playedBoosters", playedBoosters);
            this.set("selectedBoosterNum", boosterNum);
            this.set("selectedBooster", this.get("boosters")[boosterNum]);

        },

        cardSelected: function(card) {
            var pickPercentage = this.getCardPickPercentage(this.get("currentPick"), card);
            this.set("guessedCard", card);
            this.set("pickPercentage", pickPercentage);
            $.ajax({
                url: "/savePick",
                type: "PUT",
                data: JSON.stringify({
                    card: card.dbKey,
                    pick: this.get("currentPick"),
                    draftId: this.get("id")

                })
            });
            var guessedCorrectly = false;
            var selectedBooster = this.get("boosters")[this.get("selectedBoosterNum")];
            for (var i=0; i<selectedBooster.picks.length; i++) {
                if (card.src===selectedBooster.picks[i].src) {
                    if (this.get("currentPick")===i) {
                        guessedCorrectly = true;
                        this.set("score", this.get("score")+this.get("pointsPerPick")[i]);
                        this.set("correctGuesses", this.get("correctGuesses")+1);
                    } else {
                    }
                    break;
                }
            }
            // add selected cards to the selected cards view,
            var selectedCard = selectedBooster.picks[this.get("currentPick")];
            this.set("currentPick", this.get("currentPick")+1);
            if (this.get("currentPick")===15) {
                this.set("isGameOver", true);
            }
            var newPickedCards = this.get("pickedCards").slice();
            selectedCard.set("pickedAt", this.get("currentPick")-1);

            newPickedCards.push(selectedCard);
            // move to the next booster and remove n picks from it
            var nextBoosterNum = (this.get("selectedBoosterNum")-1)%8;
            if (nextBoosterNum<0) {
                nextBoosterNum+=8;
            }
            // copy the array so we don't overwrite the original one.
            var nextBooster = this.get("boosters")[nextBoosterNum].picks.slice();
            for (var i=0; i<this.get("currentPick"); i++) {
                nextBooster.shift();
            }
            this.set("correctCard", selectedCard);
            this.set("modalHeader", this.getModalHeader(guessedCorrectly));
            $('.modal').modal('show');
            this.set("selectedBooster", {picks:nextBooster});
            this.set("selectedBoosterNum", nextBoosterNum);
            this.set("pickedCards", newPickedCards);
        }
    }
});