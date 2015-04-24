App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    boosterView: true,
    columnView: false,
    startHelpNeeded: true,
    init: function() {
        this._super();
        this.set("drafts", drafts);
        setTimeout((function() {
            if (this.get("startHelpNeeded")) {
                $("#startHelp").show().animate({top: "-=20", opacity: 1})
            }
        }).bind(this), 3000);
    },
    actions: {
        setView: function(mode) {
            this.set("boosterView", mode==="booster");
            this.set("columnView", mode==="column");
        }
    }
});