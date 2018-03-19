import QtQuick 2.0
import QtQuick.Controls 2.0
Rectangle {
    id: raiz
    width: parent.width
    height: parent.height
    color: app.c5

        Column{
            id:col
            width: parent.width-app.fs
            spacing: app.fs
            Rectangle{
                id: tb
                width: raiz.width
                height: app.fs*1.4
                color: app.c1
                Text {
                    id: txtTit
                    text: 'unik-configuration'
                    font.pixelSize: app.fs
                    color: app.c4
                    anchors.centerIn: parent
                }
            }
            Row{
                spacing: app.fs*0.5
                Text {
                    id: labelWS
                    text: 'Espacio de Trabajo:'
                    font.pixelSize: app.fs
                    color: app.c1
                }
                Rectangle{
                    id: xTiWS
                    width: raiz.width-labelWS.contentWidth-botAplicarWS.width-app.fs*2
                    height: app.fs*1.2
                    color: "#333"
                    border.color: app.c2
                    radius: app.fs*0.1
                    clip: true
                    TextInput{
                        id: tiWS
                        width: parent.width*0.98
                        height: app.fs
                        font.pixelSize: app.fs
                        text: appsDir
                        anchors.centerIn: parent
                        Keys.onReturnPressed: {
                                        setWS(tiWS.text)
                        }
                        onTextChanged: {
                            tiWS.color = unik.fileExist(tiWS.text)?app.c1:"red"
                        }
                    }
                }

                Button{
                    id: botAplicarWS
                    height: app.fs*1.4
                    text: 'Aplicar'
                    font.pixelSize: app.fs
                    background: Rectangle{color:app.c2; radius: app.fs*0.3;}
                    onClicked: {
                        unik.setWorkSpace('')
                    }
                }

            }
        }
        function setWS(ws){
            if(unik.fileExist(ws)||unik.mkdir(ws)){
                unik.setWorkSpace(ws)
                unik.log('New WorkSpace seted: '+ws)
            }
            tiWS.color = unik.fileExist(ws)?app.c1:"red"
        }

}
