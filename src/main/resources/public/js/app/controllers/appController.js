App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    boosterView: true,
    columnView: false,
    playerView: false,
    startHelpNeeded: true,
    viewModeChanged: false,
    viewingDraft: false,
    viewingGame: false,
    isGameMode: false,
    showModeToggler: true,
    showNewsPopup: false,
    latestNews: [
        "Added Pro Tour Origins Drafts",
        "Pick statistics shown in Training mode",
        "Added Training mode"
    ],
    latestNewsSeen: 0,
    hasNews: function() {
        return this.get("latestNews").length;
    }.property("latestNews"),
    onPathChange: function() {
        this.set("viewingDraft", this.get("currentPath")==="draft.view");
        this.set("viewingGame", this.get("currentPath")==="draft.game");
        this.set("showModeToggler", !this.get("viewingDraft") && !this.get("viewingGame"));
        $("#startHelp").hide();
        if (this.get("currentPath").indexOf("draft")>-1) {
            this.set("startHelpNeeded", false);
        }
    }.observes("currentPath"),
    init: function() {
        var latestNewsSeen = $.cookie("p1p1_newsSeen");
        this.set("latestNewsSeen", latestNewsSeen ? parseInt(latestNewsSeen, 10) : 0);
        $.cookie("p1p1_newsSeen", this.get("latestNews").length);
        while (latestNewsSeen) {
            latestNewsSeen--;
            this.get("latestNews").pop();
        }
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
        },
        toggleNewsPopup: function() {
            this.toggleProperty("showNewsPopup");
        },
        setGameMode: function(on) {
            this.set("isGameMode", on);
        }
    }
});