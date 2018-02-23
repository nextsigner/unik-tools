import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.2
import uk 1.0
Item {
    id: raiz
    property int nindex: 0
    //anchors.fill: parent

    UK{
        id: ukAyuda
    }

    Rectangle{
        id: tb
        width: raiz.width/2
        height: appRoot.fs*1.4
        color: appRoot.c1
        opacity: raiz.nindex === 0 ? 1.0 : 0.5
        Text {
            id: txtTit
            text: qsTr("Detalles de unik")
            font.pixelSize: appRoot.fs
            color: appRoot.c4
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                raiz.nindex = 0
            }
        }
    }
    Rectangle{
        id: tb2
        width: raiz.width/2
        height: appRoot.fs*1.4
        color: appRoot.c1
        anchors.left: tb.right
        opacity: raiz.nindex === 1 ? 1.0 : 0.5
        Text {
            id: txtTit2
            text: qsTr("Ayuda de unik")
            font.pixelSize: appRoot.fs
            color: appRoot.c4
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                raiz.nindex = 0
            }
        }
    }
    Rectangle{
        width: raiz.width
        height: raiz.height-tb.height
        anchors.top: tb.bottom
        color: appRoot.c5
        Text {
            id: txtDetalles
            font.pixelSize: appRoot.fs
            anchors.centerIn: parent
            color: appRoot.c2
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            Component.onCompleted: {
                var det = '<b>unik version:</b> '+version
                det    += '<br><b>unik-tools version:</b> 1.1'
                det    += '<br><b>unik host:</b> '+host
                det    += '<br><b>user host:</b> '+userhost
                txtDetalles.text = det
            }
        }
    }
    ListView{
        id: listItemAyuda
        width: raiz.width-appRoot.fs
        height: raiz.height-tb.height
        anchors.top: tb.bottom
        anchors.horizontalCenter: raiz.horizontalCenter
        //model: folderListModelApps
        delegate: delItemAyuda
        clip: true
        spacing: appRoot.fs*0.2
    }
    Component{
        id: delItemAyuda
        Rectangle{
            id: xItem
            width: listItemAyuda.width
            height: appRoot.fs*1.6
            color: appRoot.c5
            border.width: 1
            border.color: appRoot.c2
            radius: appRoot.fs*0.5

            Text {
                id: txtTitulo
                text: tit
                font.pixelSize: appRoot.fs
                anchors.centerIn: parent
            }
            Text{
                id: txtDes
                text: des
                font.pixelSize: appRoot.fs
            }

        }
    }
    DialogoConfirmar{
        id: dc
        width: parent.width*0.6
        height: parent.height*0.5
        anchors.centerIn: parent
        visible: false
        property string dato1
        onVisibleChanged: {
            if(!visible){
                 if(dc.estadoSalida===0){
                    console.log("No Acepta eliminar")
                 }
                 if(dc.estadoSalida===1){
                    console.log("Acepta eliminar")
                     var urlUpk = appsDir+'/'+dc.dato1
                     var urlUpk1 = urlUpk.replace('file:///', '')
                     console.log("Eliminando "+urlUpk1)
                     uk.deleteFile(urlUpk1)
                 }
            }
        }

    }

}
