import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import uk 1.0

Item{
    id:raiz
    property int modo: 1
    UK{
        id: ukTools
    }
    Rectangle{
        id: tb1
        width: raiz.width/2
        height: appRoot.fs*1.4
        color: appRoot.c1
        opacity: raiz.modo === 1 ? 1.0 : 0.5
        Text{
            text: '<b>unik App Store</b>'
            font.pixelSize: appRoot.fs
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                raiz.modo = 1
            }
        }
    }
    Rectangle{
        width: raiz.width/2
        height: appRoot.fs*1.4
        color: appRoot.c1
        opacity: raiz.modo === 2 ? 1.0 : 0.5
        anchors.left: tb1.right
        Text{
            text: '<b>Instalar aplicación</b>'
            font.pixelSize: appRoot.fs
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                raiz.modo = 2
            }
        }
    }
    Item{
        id: xAppStoreList
        width: raiz.width
        height: raiz.height-appRoot.fs*1.4
        anchors.top: tb1.bottom
        visible: raiz.modo === 1
        ListView{
            id: listApps
            width: raiz.width-appRoot.fs
            height: raiz.height-tb1.height            
            anchors.horizontalCenter: parent.horizontalCenter
            model: lmApps
            delegate: delListApp
            clip: true
            spacing: appRoot.fs*0.2
        }
        ListModel{
            id: lmApps
                function add(ran){
                    return {
                        remotoAppName: ran
                    }
                }

        }

        Component{
            id: delListApp
            Rectangle{
                id: xItem
                width: listApps.width
                height: appRoot.fs*1.6
                color: appRoot.c2
                border.width: 1
                radius: height*0.1
                property int porcDL: 0
                UK{
                    id: ukItem
                }
                Connections {
                    target: ukItem
                    onPorcChanged: {
                        //console.log("Porc------------------------->:"+ukItem.getPorc())
                        xItem.porcDL = ukItem.getPorc()
                        bgDL.width = bgDL.parent.width*(xItem.porcDL/100)
                        if(xItem.porcDL===100){
                            dlprogress.opacity = 0.0
                            botDesc.enabled = true
                            taLog.log('Descarga finalizada de '+remotoAppName+' %'+xItem.porcDL)
                        }else{
                            taLog.log('Descargando '+remotoAppName+' %'+xItem.porcDL)
                        }
                    }
                    onUkStdChanged: {
                        taLog.log(ukItem.getUkStd())
                    }
                }
                Text {
                    id: txtFileName
                    text: remotoAppName
                    font.pixelSize: appRoot.fs
                    anchors.centerIn: parent
                    //color: bgDL.width<xItem.width ? appRoot.c1 : appRoot.c5
                }
                Rectangle{
                    id: dlprogress
                    width: appRoot.fs*5
                    height: parent.height*0.8
                    radius: height*0.1
                    color: appRoot.c5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height*0.1
                    opacity: 0.0
                    Behavior on opacity{
                        NumberAnimation{
                            duration: 2000
                        }
                    }
                    Rectangle{
                        id:bgDL
                        width: 0
                        height: parent.height*0.5
                        color: appRoot.c2
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height*0.05

                        //anchors.centerIn: parent
                        radius: height*0.1
                    }
                    Text {
                        id: pdl
                        text: '%'+xItem.porcDL
                        font.pixelSize: xItem.height*0.25
                        color: appRoot.c2
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: parent.height*0.05
                    }
                }



                Row{
                    height: xItem.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: xItem.height*0.2
                    spacing: appRoot.fs*0.5

                    Button{//Descargar
                        id: botDesc
                        width: parent.height
                        height: width
                        text: '\uf019'
                        font.family: "FontAwesome"
                        font.pixelSize: xItem.height*0.8
                        background: Rectangle{color:appRoot.c1; radius: appRoot.fs*0.3;}
                        onClicked: {
                            var url =  host+'/users/unik-free/upks/'+remotoAppName
                            dlprogress.opacity = 1.0
                            botDesc.enabled = false
                            //var url =  'http://codigosenaccion.com/nube/roman.mp4'
                            var nAppsDir = (''+appsDir).replace('file:///', '')

                            var upkDestination = nAppsDir+'/'+remotoAppName
                            //console.log("UPK Origin: "+url)
                            //console.log("UPK Destination: "+upkDestination)
                            var code = '<b>Code JavaScript:</b><br />var upkDestination = '+nAppsDir+'/'+remotoAppName+'<br />'
                            code+='var url =  host+\'/users/unik-free/upks/'+remotoAppName+'<br />'
                            code += 'ukItem.setFile(upkDestination, ukItem.getHttpFile(url))'
                            taLog.log(code)
                            //ukItem.setPorc(0)
                            ukItem.setFile(upkDestination, ukItem.getHttpFile(url))                            
                        }
                    }
                }
            }
        }
    }


    Item{
        id: xAppManager
        width: raiz.width
        height: raiz.height-appRoot.fs*1.4
        visible: raiz.modo === 2
        ColumnLayout{
            id: col1
            anchors.centerIn: parent
            Layout.preferredWidth: appRoot.width*0.8
            Layout.preferredHeight: parent.height*0.5
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: appRoot.fs


            RowLayout{
                id: row1
                Layout.fillWidth: true
                Layout.preferredWidth:appRoot.width*0.8
                Layout.preferredHeight: appRoot.fs
                spacing: appRoot.fs
                Text {
                    id: txtSetUser
                    font.pixelSize: appRoot.fs
                    color: appRoot.c1
                    text: '<b>Usuario:</b>'
                    clip: true
                }
                Rectangle{
                    id:xtiSetUser
                    Layout.minimumWidth: appRoot.width*0.8-txtSetUser.width-appRoot.fs                    //Layout.maximumWidth: (parent.parent.parent.width-txtSetUser.width-appRoot.fs)*0.6
                    Layout.minimumHeight: appRoot.fs*1.6
                    Layout.maximumHeight: appRoot.fs*1.6
                    anchors.verticalCenter: txtSetUser.verticalCenter
                    border.width: 1
                    border.color: appRoot.c1
                    radius: height*0.3
                    clip: true
                    color: appRoot.c2
                    TextInput{
                        id: tiSetUser
                        font.pixelSize: appRoot.fs
                        width: parent.width*0.99
                        height: appRoot.fs
                        anchors.centerIn: parent
                        maximumLength: 60
                    }

                }
            }


            RowLayout{
                id: row3
                Layout.fillWidth: true
                Layout.preferredWidth:appRoot.width*0.8
                Layout.preferredHeight: appRoot.fs
                spacing: appRoot.fs
                Text {
                    id: txtSetKey
                    font.pixelSize: appRoot.fs
                    color: appRoot.c1
                    text: '<b>App id:</b>'
                    clip: true
                }
                Rectangle{
                    id:xtiSetKey
                    Layout.minimumWidth: appRoot.width*0.8-txtSetKey.width-appRoot.fs                    //Layout.maximumWidth: (parent.parent.parent.width-txtSetUser.width-appRoot.fs)*0.6
                    Layout.minimumHeight: appRoot.fs*1.6
                    Layout.maximumHeight: appRoot.fs*1.6
                    anchors.verticalCenter: txtSetKey.verticalCenter
                    border.width: 1
                    border.color: appRoot.c1
                    color: appRoot.c2
                    radius: height*0.3
                    clip: true
                    TextInput{
                        id: tiSetKey
                        font.pixelSize: appRoot.fs
                        width: parent.width*0.99
                        height: appRoot.fs
                        anchors.centerIn: parent
                        maximumLength: 60
                    }
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredWidth: appRoot.width*0.8
                Layout.minimumHeight:  appRoot.fs
                spacing: 0
                //                CheckBox{
                //                    id: recordarme
                //                    width: appRoot.fs
                //                    height: appRoot.fs
                //                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: appRoot.fs
                }
                Button{
                    Layout.preferredWidth: appRoot.fs*6
                    Layout.preferredHeight: 50
                    text: 'Enviar'
                    font.pixelSize: appRoot.fs*0.8
                    background: Rectangle{color:appRoot.c2}
                    onClicked: {
                        if(tiSetUser.text!==''){
                            if(qkey.login(tiSetUser.text+'@@@'+tiSetKey.text)&&recordarme.checked){
                                qkey.encriptar('.')
                            }else{

                            }
                        }
                    }
                }
            }
        }
    }    

    Component.onCompleted: {
        updateRemoteApps()
        /*console.log("OS: "+Qt.platform.os)
        console.log("Recordar Key: "+qkey.login('.'))
        if(qkey.login('.')){
            xAppManager.visible = false
        }*/
        if(Qt.platform.os==='linux'){
            appRoot.visibility = "Maximized"
        }
        /*var d = new Date(Date.now())
        var d2 = new Date(d.getFullYear()+1, d.getMonth(), d.getDate(), d.getHours(), d.getMilliseconds(), d.getSeconds(), d.getMilliseconds())
        var d3 = new Date(d.getFullYear()+2, d.getMonth(), d.getDate(), d.getHours(), d.getMilliseconds(), d.getSeconds(), d.getMilliseconds())
        var d4 = new Date(d.getFullYear()+3, d.getMonth(), d.getDate(), d.getHours(), d.getMilliseconds(), d.getSeconds(), d.getMilliseconds())
        var c1 = ''+d.getTime()+''+d2.getTime()+''+d3.getTime()+''+d4.getTime()+''
        var c2 = c1+c1+'cris'
        oc.grabarClave(c2)
        */
    }
    function setUser(user, key){
        var http = new XMLHttpRequest()
        var d = new Date(Date.now())
        var url = 'http://codigosenaccion.com/unik/modulos/setUser.php?user='+user+'&key='+key
        http.onreadystatechange = function() {
            if (http.status == 200) {
                console.log(http.responseText)
            }
        };

    }
    function updateRemoteApps(){
        lmApps.clear()
        var url =  host+'/getFreeApps.php'
        var json = ukTools.getHttpFile(url)
        var datos = JSON.parse(json)
        for(var i=0; i< Object.keys(datos).length; i++){
            lmApps.append(lmApps.add(datos['f'+i]))
        }
    }
    /*Component.onCompleted: {
        //engine.rootContext load('http://codigosenaccion.com/apps/unik/getMainQml.php')
        oc.sqliteInit('base1.sqlite', true);
        var sql = 'CREATE TABLE IF NOT EXISTS tabla1(
                   ID INTEGER PRIMARY KEY AUTOINCREMENT,
                   DATO TEXT
                    )'
        oc.sqlite(sql, true)
        sql = 'INSERT INTO TABLA1(DATO)VALUES(\'HOLA\')'
        oc.sqlite(sql, true)
        console.log(oc.getJsonSqlite('*', 'tabla1', '', true))

    }*/
}
