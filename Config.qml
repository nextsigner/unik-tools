import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0
Rectangle {
    id: raiz
    width: parent.width
    height: parent.height
    color: app.c5

        ColumnLayout{
            id:col
            width: parent.width-app.fs
            anchors.horizontalCenter: raiz.horizontalCenter
            spacing: app.fs
            Rectangle{
                id: tb
                Layout.fillWidth: true
                Layout.preferredHeight: app.fs*1.4
                color: app.c1
                Text {
                    id: txtTit
                    text: 'unik-configuration'
                    font.pixelSize: app.fs
                    color: app.c4
                    anchors.centerIn: parent
                }
            }
            RowLayout{
                spacing: app.fs*0.5
                Layout.preferredWidth: parent.width
                Text {
                    id: labelWS
                    text: 'Espacio de Trabajo:'
                    font.pixelSize: app.fs
                    color: app.c1
                }
                Rectangle{
                    id: xTiWS
                    //width: raiz.width-labelWS.contentWidth-botAplicarWS.width-app.fs*2
                    Layout.fillWidth: true
                    Layout.preferredHeight:  app.fs*1.2
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

                Boton{
                    w:app.fs*1.2
                    h:w
                    b:app.c2
                    c: "#333"
                    t: "..."
                    d: 'Seleccionar Carpeta para Espacio de Trabajo'
                    tp:1
                    onClicking: folderDialog.visible=true
                }

                Button{
                    id: botAplicarWS
                    height: app.fs*1.2
                    text: 'Aplicar'
                    font.pixelSize: app.fs
                    background: Rectangle{color:app.c2; radius: app.fs*0.3;}
                    onClicked: {
                        unik.setWorkSpace('')
                    }
                }

            }
        }
        FolderDialog {
            id: folderDialog
            currentFolder: tiWS.text
            folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            options: FolderDialog.ShowDirsOnly
            visible: false
            onAccepted: {
                tiWS.text=(''+folderDialog.currentFolder).replace('file://', '')
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
