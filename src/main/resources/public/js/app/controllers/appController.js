App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    init: function() {
        this._super();
        for (var i=0; i<draftsData.length; i++) {
            var draft = App.Draft.create();
            var data = JSON.parse(draftsData[draftsData.length-i-1]);
            draft.set("name", data.name);
            draft.set("picks", data.picks);
            draft.set("players", data.players);
            draft.set("url", data.url);
            this.get("drafts").push(draft);
        }
    }
});