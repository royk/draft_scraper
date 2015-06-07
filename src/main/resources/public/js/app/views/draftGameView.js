App.DraftGameView = Ember.View.extend({
    willInsertElement: function() {
        this._super();
        this.get("controller").send("startGame");
    },
	didInsertElement: function() {
		$(window).keypress(function(e) {
			if (e.keyCode===13) {
				$('.modal').modal('hide');
			}
		})
	}
});