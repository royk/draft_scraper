App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    boosterView: true,
    columnView: false,
    playerView: false,
    startHelpNeeded: true,
    viewModeChanged: false,
    viewingDraft: false,
    onPathChange: function() {
        this.set("viewingDraft", this.get("currentPath")==="draft.view");
    }.observes("currentPath"),
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
            this.set("playerView", mode==="player");
            this.toggleProperty("viewModeChanged");
        }
    }
});