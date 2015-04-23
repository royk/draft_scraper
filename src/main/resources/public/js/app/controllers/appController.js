App.ApplicationController = Ember.Controller.extend({
    drafts: [],
    init: function() {
        this._super();
        this.set("drafts", drafts);
    }
});