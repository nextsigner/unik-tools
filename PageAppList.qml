import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.2
Item {
    id: raiz
    //anchors.fill: parent
    property alias flm: folderListModelApps
    Connections {target: unik;onUkStdChanged: logView.log(unik.ukStd);}
    Connections {target: unik;onStdErrChanged: logView.log(unik.getStdErr());}
    Rectangle{
        id: tb
        width: raiz.width
        height: app.fs*1.4
        color: app.c1
        Text {
            id: txtTit
            text: qsTr("Lista de Aplicaciones Instaladas")
            font.pixelSize: app.fs
            color: app.c4
            anchors.centerIn: parent
        }
    }


    ListView{
        id: listApps
        width: raiz.width-app.fs
        //height: raiz.height-tb.height
        anchors.top: tb.bottom
        anchors.bottom: lineRH.top
        anchors.horizontalCenter: raiz.horizontalCenter
        model: folderListModelApps
        delegate: delListApp
        clip: true
        spacing: app.fs*0.2
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
            height: app.fs*1.6
            color: app.appVigente+'.upk'===fileName ? app.c1 : app.c2
            border.width: 1
            radius: height*0.1

            Text {
                id: txtFileName
                text: fileName
                font.pixelSize: app.fs
                anchors.centerIn: parent
            }
            Text{
                anchors.left: parent.left
                anchors.leftMargin: app.fs*0.2
                anchors.verticalCenter: parent.verticalCenter
                text: '\uf192'
                font.family: "FontAwesome"
                font.pixelSize: xItem.height*0.8
                visible: app.appVigente+'.upk'===fileName
            }
            Row{
                height: xItem.height*0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: xItem.height*0.2
                spacing: app.fs*0.5
                Button{//Ejecutar
                    id: btnRun
                    width: parent.height
                    height: width
                    text: '\uf135'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    //opacity: app.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    background: Rectangle{color: app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}

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
                        var cl
                        if(!folderListModelApps.isFolder(index)){
                            taLog.log("Lanzando upk: "+fileName)
                            var c1 = ''+fileName
                            var c2 = c1.replace('.upk', '')
                            taLog.log("Lanzando appName: "+c2)
                            taLog.log("Location 1: "+unik.getPath(1))
                            var exe = ''+unik.getPath(0)
                            if(Qt.platform.os==='linux'){
                                exe+='.AppImage'
                            }


                            cl = '"'+unik.getPath(1)+'/'+exe+'" -appName '+c2
                            /*if(Qt.platform.os==='windows'){
                                cl= '"'+unik.getPath(1)+'/unik.exe" -appName '+c2
                            }else if(Qt.platform.os==='linux'){
                                cl= '"'+unik.getPath(1)+'/unik.AppImage" -appName '+c2
                            }else{
                                cl= '"'+unik.getPath(1)+'/unik" -appName '+c2
                            }*/

                            taLog.log("CommandLine: "+cl)
                            unik.run(cl)
                        }else{
                            taLog.log("Lanzando carpeta "+fileName)
                            var urlUpk0 = ''+appsDir
                            var urlUpk1 = (urlUpk0.replace('file:///', ''))+'/'+fileName
                            taLog.log("Carpeta a ejecutar "+urlUpk1)
                            cl = ' -folder '+urlUpk1

                            //var cl2 = ''+unik.getPath(1)+'/unik.exe -foldertoupk '+urlUpk1
                            var appPath
                            if(Qt.platform.os==='osx'){
                                appPath = '"'+unik.getPath(1)+'/'+unik.getPath(0)+'"'
                            }
                            if(Qt.platform.os==='windows'){
                                appPath = '"'+unik.getPath(1)+'/'+unik.getPath(0)+'"'
                            }
                            if(Qt.platform.os==='linux'){
                                appPath = '"'+appExec+'"'
                            }
                            taLog.log('Running: '+appPath+' '+cl)
                            unik.run(appPath+' '+cl)
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
                            var isFree=unik.isFree(upk)
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
                    opacity: app.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    background: Rectangle{color: app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}
                    onClicked: {
                        if((''+fileName).indexOf('.upk')<0){
                            var c = ''+unik.getPath(3)+'/unik/'+fileName
                            var json='{"mode":"-folder", "arg1":"'+c+'"}'
                            app.appVigente = fileName
                            var c2 = ''+unik.getPath(3)+'/unik/config.json'
                            unik.setFile(c2, json)
                            logView.log('Aplicaciòn por defecto: '+c)
                            logView.log('Nuevo Json Config: '+c2)
                        }else{
                            var c1 = ''+fileName
                            var c2 = c1.split('.upk')
                            app.appVigente = c2[0]
                        }

                    }
                }
                Button{//Descargar
                    width: parent.height
                    height: width
                    text: '\uf019'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}
                    visible: false
                }
                Button{//Actualizar
                    id:botActualizarGit
                    width: parent.height
                    height: width
                    text: '\uf09b'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:app.c1; radius: app.fs*0.3;}
                    opacity:  (''+fileName).indexOf('unik-qml')===0 ? 1.0 : 0.0
                    enabled: opacity===1.0
                    onClicked: {
                        var url = 'https://github.com/nextsigner/'+fileName
                        logView.log('Actualizando '+url)
                        var carpetaLocal=unik.getPath(3)+'/unik'
                        logView.log('Actualizando en carpeta '+carpetaLocal)
                        listApps.enabled=false
                        botActualizarGit.enabled=false
                        var actualizado = unik.downloadGit(url, carpetaLocal)
                        logView.log('Actualizado: '+actualizado)
                        listApps.enabled=true
                        botActualizarGit.enabled=true

                    }
                    Text {
                        text: '\uf019'
                        font.family: "FontAwesome"
                        font.pixelSize: xItem.height*0.3
                        anchors.centerIn: parent
                    }
                }
                Button{//Eliminar
                    width: parent.height
                    height: width
                    text: '\uf014'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}
                    opacity: (''+fileName).indexOf('.upk')===0 ? 1.0 : 0.0
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


    LineResizeH{id:lineRH; y:visible?appSettings.pyLineRH1: parent.height;onLineReleased: appSettings.pyLineRH1 = y; visible: appSettings.logVisible;/*onYChanged: wv.height = !lineRH.visible ? wv.parent.height-(wv.parent.height-lineRH.y) : wv.parent.height*/}
    LogView{
        id:logView;
        width: raiz.width
        anchors.top: lineRH.bottom;
        anchors.bottom: parent.bottom;
        visible: appSettings.logVisible;
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
                    unik.deleteFile(urlUpk1)
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
