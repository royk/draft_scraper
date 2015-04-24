App.DraftViewView = Ember.View.extend({
    didInsertElement: function() {
            this.get("controller").animateCards();
    }
});