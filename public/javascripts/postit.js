$(function() {
    $(".postit").draggable({
        handle: "img",
        revert: "invalid"
    });

    $( ".droppable" ).droppable({
		hoverClass: "ui-state-hover",
	});
});

