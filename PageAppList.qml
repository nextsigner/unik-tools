import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.2
Item {
    id: raiz
    //anchors.fill: parent
    property alias flm: folderListModelApps
    Rectangle{
        id: tb
        width: raiz.width
        height: appRoot.fs*1.4
        color: appRoot.c1
        Text {
            id: txtTit
            text: qsTr("Lista de Aplicaciones Instaladas")
            font.pixelSize: appRoot.fs
            color: appRoot.c4
            anchors.centerIn: parent
        }
    }


    ListView{
        id: listApps
        width: raiz.width-appRoot.fs
        height: raiz.height-tb.height
        anchors.top: tb.bottom
        anchors.horizontalCenter: raiz.horizontalCenter
        model: folderListModelApps
        delegate: delListApp
        clip: true
        spacing: appRoot.fs*0.2
    }
    FolderListModel{
        id: folderListModelApps
        folder: appsDir
        nameFilters: ["*.upk"]
    }

    Component{
        id: delListApp
        Rectangle{
            id: xItem
            width: listApps.width
            height: appRoot.fs*1.6
            color: appRoot.appVigente+'.upk'===fileName ? appRoot.c1 : appRoot.c2
            border.width: 1
            radius: height*0.1

            Text {
                id: txtFileName
                text: fileName
                font.pixelSize: appRoot.fs
                anchors.centerIn: parent
            }
            Text{
                anchors.left: parent.left
                anchors.leftMargin: appRoot.fs*0.2
                anchors.verticalCenter: parent.verticalCenter
                text: '\uf192'
                font.family: "FontAwesome"
                font.pixelSize: xItem.height*0.8
                visible: appRoot.appVigente+'.upk'===fileName
            }
            Row{
                height: xItem.height*0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: xItem.height*0.2
                spacing: appRoot.fs*0.5
                Button{//Ejecutar
                    id: btnRun
                    width: parent.height
                    height: width
                    text: '\uf135'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    //opacity: appRoot.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    background: Rectangle{color: appRoot.appVigente+'.upk'===fileName ? appRoot.c2 : appRoot.c1; radius: appRoot.fs*0.3;}

                    Text {
                        id: name
                        text: '<b>No Free</b>'
                        anchors.centerIn: parent
                        font.pixelSize: parent.height*0.2
                        color: "red"
                        visible: !parent.enabled
                    }
                    onClicked: {
                        taLog.log("Index presionado: "+index)
                        if(!folderListModelApps.isFolder(index)){
                            taLog.log("Lanzando upk: "+fileName)
                            var c1 = ''+fileName
                            var c2 = c1.replace('.upk', '')
                            taLog.log("Lanzando appName: "+c2)
                            taLog.log("Location 1: "+uk.getPath(1))
                            var exe = ''+uk.getPath(0)
                            if(Qt.platform.os==='linux'){
                                exe+='.AppImage'
                            }

                            var cl
                            cl = '"'+uk.getPath(1)+'/'+exe+'" -appName '+c2
                            /*if(Qt.platform.os==='windows'){
                                cl= '"'+uk.getPath(1)+'/unik.exe" -appName '+c2
                            }else if(Qt.platform.os==='linux'){
                                cl= '"'+uk.getPath(1)+'/unik.AppImage" -appName '+c2
                            }else{
                                cl= '"'+uk.getPath(1)+'/unik" -appName '+c2
                            }*/

                            taLog.log("CommandLine: "+cl)
                            uk.run(cl)
                        }else{
                            taLog.log("Lanzando carpeta "+fileName)
                            var urlUpk0 = ''+appsDir
                            var urlUpk1 = (urlUpk0.replace('file:///', ''))+'/'+fileName
                            taLog.log("Carpeta para upkar "+urlUpk1)

                            var cl2 = ''+uk.getPath(1)+'/unik.exe -foldertoupk '+urlUpk1
                            taLog.log("CL: "+cl2)
                            uk.run(cl2)
                        }
                        /*taLog.log("Lanzando "+urlUpk1)
                        dc.dato1 = urlUpk1
                        dc.estadoEntrada = 2
                        dc.titulo = '<b>Confirmar Modo</b>'
                        dc.consulta = 'Lanzar cerrando esta aplicación\n'+appName+'?'
                        dc.ctx = 'SiNo'
                        dc.visible = true*/
                    }
                    Component.onCompleted: {
                        if(!folderListModelApps.isFolder(index)){
                            var upk = unikDocs+'/'+fileName
                            var isFree=uk.isFree(upk)
                            btnRun.enabled = isFree
                            console.log(""+upk+" free: "+isFree)
                        }
                    }
                }
                Button{//Seleccionar
                    width: parent.height
                    height: width
                    text: '\uf00c'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    opacity: appRoot.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    background: Rectangle{color: appRoot.appVigente+'.upk'===fileName ? appRoot.c2 : appRoot.c1; radius: appRoot.fs*0.3;}
                    onClicked: {
                        var c1 = ''+fileName
                        var c2 = c1.split('.upk')
                        appRoot.appVigente = c2[0]
                    }
                }
                Button{//Descargar
                    width: parent.height
                    height: width
                    text: '\uf019'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:appRoot.appVigente+'.upk'===fileName ? appRoot.c2 : appRoot.c1; radius: appRoot.fs*0.3;}
                }
                Button{//Eliminar
                    width: parent.height
                    height: width
                    text: '\uf014'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:appRoot.appVigente+'.upk'===fileName ? appRoot.c2 : appRoot.c1; radius: appRoot.fs*0.3;}
                    opacity: appRoot.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    onClicked: {
                        dc.dato1 = fileName
                        dc.estadoEntrada = 1
                        dc.titulo = '<b>Confirmar eliminación</b>'
                        dc.consulta = 'Está seguro que desea eliminar\n'+fileName+'.upk?'
                        dc.visible = true

                    }
                }
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
                if(dc.estadoEntrada===1&&dc.estadoSalida===0){
                    taLog.log("No Acepta eliminar")
                }
                if(dc.estadoEntrada===1&&dc.estadoSalida===1){
                    taLog.log("Acepta eliminar")
                    var urlUpk = appsDir+'/'+dc.dato1
                    var urlUpk1 = urlUpk.replace('file:///', '')
                    taLog.log("Eliminando "+urlUpk1)
                    uk.deleteFile(urlUpk1)
                }
                if(dc.estadoEntrada===2&&dc.estadoSalida===1){
                    ukit.loadUpk(dc.dato1, true)
                }
                if(dc.estadoEntrada===2&&dc.estadoSalida===0){
                    ukit.loadUpk(dc.dato1, false)
                }


            }
        }

    }

}
