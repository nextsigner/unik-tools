import QtQuick 2.0

Item {
    property alias lm: lm2
    ListModel{
        id:lm2
        ListElement{
            nom: "RickyPapi Web Browser"
            des: "Navergador Web para Los Rickytos de Matias Ponce. Este navegador está diseñado solo para navegar por las Redes Sociales más importantes de la manera más facil, ágil y dinámica aprovechando al máximo tu pantalla."
            dev: "@nextsigner"
            urlgit: "https://github.com/nextsigner/rickypapi"
            img2: "https://github.com/nextsigner/rickypapi/blob/master/unik_rickypapi_1.PNG?raw=true"
        }

    }

}
