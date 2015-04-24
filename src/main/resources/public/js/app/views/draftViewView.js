App.DraftViewView = Ember.View.extend({
    didInsertElement: function() {
        $("#startHelp").hide();
        this.get("controller").animateCards();
    }
});