App.Draft = Ember.Object.extend({});
App.Draft.reopenClass({
    find: function(id) {
        for (var i=0; i<drafts.length; i++) {
            if (drafts[i].get("id")===id) {
                return drafts[i];
            }
        }
        return null;
    }
});
var drafts = [];
(function() {
    for (var i=0; i<draftsData.length; i++) {
        var draft = App.Draft.create();
        var data = JSON.parse(draftsData[draftsData.length-i-1]);
        draft.set("name", data.name);
        draft.set("picks", data.picks);
        if (!data.players) {
            data.players = [];
            for (var playerNum=0; playerNum<8; playerNum++) {
                data.players.push("Player "+(playerNum+1));
            }
        }
        draft.set("players", data.players);
        draft.set("url", data.url || "");
        draft.set("id", data.id);
        drafts.push(draft);
    }
})();