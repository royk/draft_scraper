<#macro header>
<html>
<head>
    <title>Flat Draft Viewer</title>
    <style>
        #wrap {
        }
        .help-container {
            position: relative;
        }
        .help {
            position: absolute;
            text-align: center;
            display: none;
            opacity: 0;
        }
        .start-help {
            top: 30px;
        }
        .cards-container {
            margin: 80px 0;
            padding: 0 !important;
        }
        .cards-container img {
            cursor: pointer;
        }
        #footer {
            height: 60px;
            background-color: #eeeeee;
            position: fixed;
            bottom: 00px;
            width: 100%;
        }
        .credit {
            margin: 20px 0;
        }
        .highlight {
            -webkit-box-shadow: 0px 0px 5px 15px rgba(0, 0, 0, 0.75);
            -moz-box-shadow:    0px 0px 5px 15px rgba(0, 0, 0, 0.75);
            box-shadow:         0px 0px 5px 15px rgba(0, 0, 0, 0.75);
            position: relative;
        }
        #showDraftControls {
            display: none;
        }
        .draftControls {
            margin: 60px 0;
        }
        .draftControls label {
            display: block;
        }
        #loadDraftControls input[type='text'] {
            width: 800px;
        }
        .nav>li.draft-control {
            display: none;
        }
        .draft-control .dropdown-menu a {
            cursor: pointer;
        }

    </style>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="http://code.jquery.com/jquery.js"></script>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
</head>
<body>
</#macro>
<#macro navbarStart>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <a class="navbar-brand" href="#">Flat Draft Viewer</a>
</#macro>
<#macro navbarEnd>
    </div>
</div>
</#macro>