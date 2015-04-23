App.DraftViewView = Ember.View.extend({
    didInsertElement: function() {
        Ember.run.scheduleOnce('afterRender', this, function() {
            $("img").tooltip({placement: "top", html: true}).mouseover(function() {
                // Has to happen outside execution scope because tooltip won't exist yet.
                setTimeout(function() {
                    var $tooltip = $(".tooltip");
                    if (!$tooltip.is(":animated")) {
                        var moveUp = 200/8;
                        $tooltip.animate({top: "-="+moveUp}, 200);
                    }
                }, 0);
            });

        });
    }
});