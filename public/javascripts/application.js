// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
    $('#project_contributor_tokens').tokenInput('/contributors.json', {
        prePopulate: $('project_contributor_tokens').data('pre'),
        preventDuplicates: true,
        hintText: 'Type in a contributor name or username',
        noResultsText: 'No contributors',
        theme: 'facebook'
    });
});

