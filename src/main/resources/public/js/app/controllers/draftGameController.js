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
            $.ajax({
                url: "/savePick",
                type: "PUT",
                data: JSON.stringify({
                    card: "test",
                    pick: this.get("currentPick")
                })
            });
            var selectedBooster = this.get("boosters")[this.get("selectedBoosterNum")];
            for (var i=0; i<selectedBooster.picks.length; i++) {
                if (card.src===selectedBooster.picks[i].src) {
                    if (this.get("currentPick")===i) {
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
            this.set("selectedBooster", {picks:nextBooster});
            this.set("selectedBoosterNum", nextBoosterNum);
            this.set("pickedCards", newPickedCards);
        }
    }
});