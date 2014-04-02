import geb.Browser


Browser.drive {
    go "http://gatherer.wizards.com/magic/draftools/draftviewer.asp?draftid=08_01_2013_1"
    output = $("h2").text()
}.quit()