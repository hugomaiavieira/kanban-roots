//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jscolor/jscolor
//= require_self
//= require_tree .

$(function() {
    $('#project_contributor_tokens').tokenInput('/contributors.json', {
        prePopulate: $('project_contributor_tokens').data('pre'),
        preventDuplicates: true,
        hintText: 'Type in a contributor name or username',
        noResultsText: 'No contributors',
        theme: 'facebook'
    });
});

