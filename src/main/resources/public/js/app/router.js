App.Router.map(function() {
    this.route("index", {path:"/"});
    this.resource("draft", {path: "/draft/:draft_id"}, function() {
        this.route("view", {path:""});
        this.route("game", {path:"game"});
    });

    App.DraftViewRoute =  Ember.Route.extend({});
    App.DraftGameRoute =  Ember.Route.extend({});
});