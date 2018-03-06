import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.2
Item {
    id: raiz
    //anchors.fill: parent
    property alias flm: folderListModelApps
    property alias dgvisible: xAddGit.visible
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


                Button{//Convertir a UPK
                    id: btnToUpk
                    width: parent.height
                    height: width
                    text: ''
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    //opacity: app.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    background: Rectangle{color: app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}
                    Text {
                        text: '<b>To</b><br /><b>UPK</b>'
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: parent.height*0.4
                    }
                    onClicked: {
                        var path = unik.getPath(3)+'/unik/'+fileName
                        toUpkDialog.currentFolder = path
                        toUpkDialog.visible = true
                    }
                    Component.onCompleted: {
                        var path = unik.getPath(3)+'/unik/'+fileName+'/main.qml'
                        btnToUpk.visible = folderListModelApps.isFolder(index)&&unik.fileExist(path)
                    }
                }



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
                        var path = unik.getPath(3)+'/unik/'+fileName
                        var cl
                        var s0=''+fileName
                        var s1= s0.substring(s0.length-4, s0.length);
                        if(!folderListModelApps.isFolder(index)&&s1==='.upk'){
                            logView.log("Lanzando upk: "+fileName)
                            var t = unik.getPath(2)+'/abc'
                            unik.mkdir(t)
                            var upkToFolder = unik.upkToFolder(path, "unik-free", "free", t)
                            if(upkToFolder){
                                engine.load(t+'/main.qml')
                            }
                            logView.log("Upk to folder: "+upkToFolder)                          
                        }else{
                            logView.log("Lanzando carpeta "+path)
                            engine.load(path+'/main.qml')
                        }
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

                Button{//Ejecutar Aparte
                    id: btnRun2
                    width: parent.height
                    height: width
                    text: ''
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    enabled: btnRun.enabled
                    //opacity: app.appVigente+'.upk'!==fileName ? 1.0 : 0.0
                    background: Rectangle{color: app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}

                    Text {
                        text: '\uf135'
                        font.family: "FontAwesome"
                        font.pixelSize: xItem.height*0.5
                        anchors.bottom: parent.bottom
                        opacity: btnRun.enabled?1.0:0.3
                        //anchors.r: parent.right
                    }
                    Text {
                        text: '\uf135'
                        font.family: "FontAwesome"
                        font.pixelSize: xItem.height*0.5
                        anchors.top: parent.top
                        anchors.right: parent.right
                        opacity: btnRun.enabled?1.0:0.3
                    }
                    Text {
                        id: name2
                        text: '<b>No Free</b>'
                        anchors.centerIn: parent
                        font.pixelSize: parent.height*0.2
                        color: "red"
                        visible: !parent.enabled
                    }
                    onClicked: {
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
                        var path = unik.getPath(3)+'/unik/'+fileName
                        var cl = '-folder '
                        var s0=''+fileName
                        var s1= s0.substring(s0.length-4, s0.length);
                        if(!folderListModelApps.isFolder(index)&&s1==='.upk'){
                            logView.log("Lanzando upk: "+fileName)
                            var d = new Date(Date.now())
                            var t = unik.getPath(2)+'/t'+d.getTime()
                            unik.mkdir(t)
                            var upkToFolder = unik.upkToFolder(path, "unik-free", "free", t)
                            if(upkToFolder){
                                cl +=''+t
                                unik.log('Running: '+appPath+' '+cl)
                                unik.run(appPath+' '+cl)
                            }
                            logView.log("Upk to folder: "+upkToFolder)
                        }else{
                            logView.log("Lanzando carpeta "+path)
                            cl+=''+path
                            unik.log('Running: '+appPath+' '+cl)
                            unik.run(appPath+' '+cl)
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
                Button{//Actualizar desde GitHub
                    id:botActualizarGit
                    width: parent.height
                    height: width
                    text: '\uf09b'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:app.c1; radius: app.fs*0.3;}
                    //opacity:  (''+fileName).indexOf('unik-qml')===0 ? 1.0 : 0.0
                    enabled: opacity===1.0
                    onClicked: {
                        var carpetaLocal=unik.getPath(3)+'/unik'
                        var ugdata = ''+unik.getFile(carpetaLocal+'/'+fileName+'/unik_github.dat')
                        var url = ugdata.replace('.git', '')
                        logView.log('Actualizando '+url)

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
                    Component.onCompleted: {
                        var e = unik.fileExist(unik.getPath(3)+'/unik/'+fileName+'/unik_github.dat')
                        botActualizarGit.opacity = e


                    }
                }
                Button{//Eliminar
                    width: parent.height
                    height: width
                    text: '\uf014'
                    font.family: "FontAwesome"
                    font.pixelSize: xItem.height*0.8
                    background: Rectangle{color:app.appVigente+'.upk'===fileName ? app.c2 : app.c1; radius: app.fs*0.3;}
                    opacity: (''+fileName).indexOf('.upk')>=0 ? 1.0 : 0.0
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


    LineResizeH{
        id:lineRH;
        y:visible?appSettings.pyLineRH1: parent.height;
        onLineReleased: appSettings.pyLineRH1 = y;
        visible: appSettings.logVisible;
        /*onYChanged: wv.height = !lineRH.visible ? wv.parent.height-(wv.parent.height-lineRH.y) : wv.parent.height*/
        onYChanged: {
            if(y<raiz.height/3){
                y=raiz.height/3+2
            }
        }
        Component.onCompleted: {
            if(lineRH.y<raiz.height/3){
                lineRH.y=raiz.height/3+2
            }
            //console.log("Line Resize LovView y: "+y)
        }
    }
    LogView{
        id:logView;
        width: raiz.width
        anchors.top: lineRH.bottom;
        anchors.bottom: parent.bottom;
        visible: appSettings.logVisible;
    }


    Rectangle{
        id: xAddGit
        width: raiz.width
        height: app.fs*4
        color: "#333"
        border.color: "white"
        radius: app.fs*0.1
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        onVisibleChanged: {
            if(visible){
                tiUrlGit.text = appSettings.uGitUrl
            }
        }
        Row{
            anchors.centerIn: parent
            height: app.fs
            spacing: app.fs
            Text {
                text: "Url GitHub: "
                font.pixelSize: app.fs
                color: app.c1
                anchors.verticalCenter: parent.verticalCenter
            }
            TextInput{
                id: tiUrlGit
                width: xAddGit.width*0.65
                height: app.fs
                font.pixelSize: app.fs
                color: text==='https://github.com/nextsigner/unik-qml-blogger.git' ? '#ccc' : 'white'
                text: 'https://github.com/nextsigner/unik-qml-blogger.git'
                anchors.verticalCenter: parent.verticalCenter
                Keys.onReturnPressed: {
                    dg()
                }
                onFocusChanged: {
                    if(text==='search'){
                        tiSearch.selectAll()
                    }
                }
                onTextChanged: {
                        appSettings.uGitUrl = text
                }
                Rectangle{
                    width: parent.width+app.fs*0.5
                    height: parent.height+app.fs*0.5
                    color: "#333"
                    border.color: app.c2
                    radius: app.fs*0.1
                    anchors.centerIn: parent
                    z:parent.z-1
                }
            }
            Boton{//Download Git
                id:btnDG
                w:app.fs
                h: w
                t: '\uf019'
                b:app.area===0?app.c2:app.c1
                anchors.verticalCenter: parent.verticalCenter
                onClicking: {
                    dg()
                }
            }
        }
        Boton{//Close
            id:btnClose
            w:app.fs
            h: w
            t: 'X'
            b:app.c1
            anchors.right: parent.right
            onClicking: {
                parent.visible = false
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
                    logView.log("No Acepta eliminar")
                }
                if(dc.estadoEntrada===1&&dc.estadoSalida===1){
                    logView.log("Acepta eliminar")
                    var urlUpk = appsDir+'/'+dc.dato1
                    var urlUpk1 = urlUpk.replace('file:///', '')
                    logView.log("Eliminando "+urlUpk1)
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
    ToUpkDialog{
        id: toUpkDialog
        width: parent.width*0.6
        height: app.fs*11
        anchors.centerIn: parent
        visible: false
    }
    Component.onCompleted: {
        if(lineRH.y<raiz.height/3){
            lineRH.y=raiz.height/3+2
        }
        //console.log("Line Resize LovView y: "+y)
    }
    function dg(){
        btnDG.enabled = false
        if(tiUrlGit.text.indexOf('https://')!==-1&&tiUrlGit.text.indexOf('/')!==-1&&tiUrlGit.text.indexOf('github.com/')!==-1){
            var check = ''+unik.getHttpFile(tiUrlGit.text.replace('.git', ''));
            unik.log('Check url github '+tiUrlGit+': '+check)
            if(check!=='Error:404'){
                var g1=tiUrlGit.text.split('/')
                var g2=(''+g1[g1.length-1]).replace('.git', '')
                var folder=unik.getPath(3)+'/unik/'
                var folder2=folder+''+g2
                unik.log('Prepare urlGit: '+tiUrlGit.text)
                unik.log('Making folder: '+folder)
                unik.mkdir(folder2)
                var urlGit=tiUrlGit.text.replace('.git', '')
                var gitDownloaded=unik.downloadGit(urlGit, folder)
                  if(gitDownloaded){
                    xAddGit.visible = false
                    btnDG.enabled = true
                    unik.log('GitHub downloaded in folder '+folder2)
                    var ugdata = tiUrlGit.text
                    unik.setFile(folder2+'/unik_github.dat', ugdata)
                    listApps.model = undefined
                    listApps.model = folderListModelApps
                    return;
                }
            }else{
                unik.log('GitHub Project Not Found.')
            }
        }else{
            unik.log('This url is no valid for this action.')
            btnDG.enabled = true
        }
    }

}
