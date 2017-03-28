CKEDITOR.editorConfig = function( config ) {
    // Define changes to default configuration here.
    // For complete reference see:
    // http://docs.ckeditor.com/#!/api/CKEDITOR.config

    // The toolbar groups arrangement, optimized for two toolbar rows.
    config.toolbarGroups = [
        // { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
        // { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
        // { name: 'insert' },
        // { name: 'forms' },
        // { name: 'document',     groups: [ 'mode', 'document', 'doctools' ] },
        // '/',
        // { name: 'colors' },
        // { name: 'about' }
        {name: 'tools'},
        {name: 'basicstyles', groups: ['basicstyles', 'cleanup']},
        {name: 'paragraph',   groups: [ 'list', 'align' ]},
        {name: 'styles'},
        {name: 'others'}
    ];

    // Remove some buttons provided by the standard plugins, which are
    // not needed in the Standard(s) toolbar.
    config.removeButtons = 'Underline,Subscript,Superscript';
    config.extraPlugins = 'markdown';  // this is the point!
    // Set the most common block elements.
    config.format_tags = 'p;h1;h2;h3;pre';

    // Simplify the dialog windows.
    config.removeDialogTabs = 'image:advanced;link:advanced';
};
