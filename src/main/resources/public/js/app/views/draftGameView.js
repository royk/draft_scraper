App.DraftGameView = Ember.View.extend({
    willInsertElement: function() {
        this._super();
        this.get("controller").send("startGame");
    }
});