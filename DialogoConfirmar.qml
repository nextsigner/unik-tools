import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: raiz
    property alias consulta: cons.text
    property alias titulo: tit.text
    property string ctx: 'AceptarCancelar'
    property int estadoEntrada: 0
    property int estadoSalida: 0
    //ES 0 cancelado
    //ES 1 aceptado

    onVisibleChanged: {
        if(!visible){
            ctx = 'AceptarCancelar'
            //estadoEntrada=0
        }
    }
    Rectangle{
        anchors.fill: raiz
        color: appRoot.c5
        border.width: 1
        border.color: appRoot.c2
        radius: appRoot.fs*0.2

        Column{
            id:col
            width: parent.width-appRoot.fs
            height: parent.height-appRoot.fs
            anchors.centerIn: parent
            spacing: appRoot.fs
            Text {
                id: tit
                font.pixelSize: appRoot.fs
                color: appRoot.c2
            }
            Text {
                id: cons
                font.pixelSize: appRoot.fs
                color: appRoot.c2
                width: raiz.width*0.8
                height: col.height-appRoot.fs*1.4-appRoot.fs*3-appRoot.fs*0.5
                wrapMode: Text.WordWrap
            }
            Row{
                anchors.right: parent.right
                anchors.rightMargin: appRoot.fs*0.5
                height: appRoot.fs*1.4
                spacing: appRoot.fs*0.5
                Button{
                    height: appRoot.fs*1.4
                    text: raiz.ctx === 'AceptarCancelar' ? "Cancelar" : "No"
                    font.pixelSize: appRoot.fs
                    background: Rectangle{color:appRoot.c2; radius: appRoot.fs*0.3;}
                    onClicked: {
                        raiz.estadoSalida = 0
                        raiz.visible = false
                    }
                }
                Button{
                    height: appRoot.fs*1.4
                    text: raiz.ctx === 'AceptarCancelar' ? "Aceptar" : "Si"
                    font.pixelSize: appRoot.fs
                    background: Rectangle{color:appRoot.c2; radius: appRoot.fs*0.3;}
                    onClicked: {
                        raiz.estadoSalida = 1
                        raiz.visible = false
                    }
                }

            }
        }
    }
}
