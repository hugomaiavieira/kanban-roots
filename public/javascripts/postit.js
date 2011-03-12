$(function() {
    $(".postit").draggable({
        handle: "img",
        revert: "invalid",
        appendTo: '.droppable'
    });

    $( ".droppable" ).droppable({
		hoverClass: "ui-state-hover",
	});
});

