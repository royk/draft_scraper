import geb.Browser

class Draft {
    String[] players = new String[8]
    String[][] picks
    Draft() {
        picks = new String[3][120]
    }
}
Browser.drive {
    int pack;
    int player;
    int pick;
    def draft = new Draft();
    int i;
    boolean playersScraped = false;
    for (pack=1; pack<4; pack++) {
        i = 0;
        for (pick=1; pick<16; pick++) {
            for (player=1; player<9; player++) {
                go baseURL+"&player="+player+"&pack="+pack+"&pick="+pick+"&showpick=true"
                if (!playersScraped) {
                    playersScraped = true;
                    def _players = $("#rightcolumn table a.small").contextElements;
                    def ii=0;
                    def playerOrders = [4,5,6,3,7,2,1,8] as int[]
                    for (_player in _players) {
                        // Last entry is not a player
                        if (ii!=8) {
                            def index = playerOrders[ii]-1;
                            draft.players[index] = _player.getText().replaceAll("\n", " ");
                            ii++;
                        }
                    }
                }
                draft.picks[pack-1][i] = $(".pickedcarddiv .cardlink img").@src;
                i++;
            }
        }
    }
    def builder = new groovy.json.JsonBuilder()
    builder {
        picks {
            data draft.picks
        }
        url baseURL
        players draft.players
    }
    output = builder.toString();
}.quit()