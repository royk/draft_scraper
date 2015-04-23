<html>
<head>
    <title>PackonePickone.com</title>
    <!--[if lt IE 9]>
    <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="//code.jquery.com/jquery.js"></script>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/base.css" rel="stylesheet">
    <link href="/css/view.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
    <script src="/js/libs/ember.debug.js"></script>
    <script src="/js/libs/ember-template-compiler.js"></script>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-55650649-1', 'auto');
        ga('send', 'pageview');
    </script>
    <#include "scripts.ftl">
    <script>
        var draftsData = ${draftsData};
    </script>
</head>
<body>
    <#include "templates.ftl">
    <div id="footer">
        <div class="container">
            <p class="text-muted credit">
                Developed by <a href="https://github.com/royk/" target="_blank">Roy Klein</a>. All content is owned by <a href="http://company.wizards.com/tou" target="_blank">Wizards of The Coast</a>.
            </p>
        </div>
    </div>
</body>
</html>