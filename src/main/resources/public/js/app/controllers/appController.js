App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    boosterView: true,
    columnView: false,
    playerView: false,
    startHelpNeeded: true,
    viewModeChanged: false,
    viewingDraft: false,
    isGameMode: false,
    onPathChange: function() {
        this.set("viewingDraft", this.get("currentPath")==="draft.view");
        this.set("isGameMode", this.get("currentPath")==="draft.game");
        $("#startHelp").hide();
        if (this.get("currentPath").indexOf("draft")>-1) {
            this.set("startHelpNeeded", false);
        }
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
        },
        selectDraft: function(draft) {
            if (this.get("isGameMode")) {
                this.transitionToRoute("draft.game", draft);
            } else {
                this.transitionToRoute("draft.view", draft);
            }
        }
    }
});