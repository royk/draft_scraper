App.Router.map(function() {
    this.route("index", {path:"/"});
    this.resource("draft", {path: "/draft/:draft_id"}, function() {
        this.route("view", {path:""});
    });

    App.DraftViewRoute =  Ember.Route.extend({});
});