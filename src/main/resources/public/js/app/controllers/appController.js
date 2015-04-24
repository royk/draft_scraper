App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    boosterView: true,
    columnView: false,
    init: function() {
        this._super();
        this.set("drafts", drafts);
    },
    actions: {
        setView: function(mode) {
            this.set("boosterView", mode==="booster");
            this.set("columnView", mode==="column");
        }
    }
});