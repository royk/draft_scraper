import geb.Browser


Browser.drive {
    def pack = 1
    def player = 1
    def pick = 1
    output = "";
    for (int i=1; i<9; i++) {
        go "http://gatherer.wizards.com/magic/draftools/draftviewer.asp?draftid=08_01_2013_1&player="+player+"&pack="+pack+"&pick="+i+"&showpick=true"
        output += $(".pickedcarddiv .cardlink img").@src + "<br/>";
    }
}.quit()