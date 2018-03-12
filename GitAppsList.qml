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
            img2: "https://github.com/nextsigner/rickypapi/blob/master/screenshot.png?raw=true"
        }
	ListElement{
		nom: "unik-qml-blogger"
		des: "Esta aplicación nos permite utilizar Blogger.com 
como un editor o entorno para publicar y probar código QML de ejemplo 
del blog sobre programación QML de @nextsigner, el suyo, otro blogger o 
sitio web en donde exista código QML disponible."
		dev: "@nextsigner"
		urlgit: "https://github.com/nextsigner/unik-qml-blogger"
		img2: "http://unikdev.net/img/screenshot.png"
	}

    }

}
