import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

ApplicationWindow{
    id: app
    visible: true
    width: 500
    height: 500
    title: qsTr("unik-tools")
    color: app.c5
    minimumWidth: 500
    minimumHeight: 500
    property int area: 0
    property bool closedModeLaunch: false
    property bool logueado: false
    property string userLogin: ''
    property string keyLog: ''

    onVisibleChanged: {
        if(!visible&&closedModeLaunch){
            app.close()
        }
    }
    onClosing: {
        Qt.quit()
    }
    onWidthChanged: {
        if(Qt.platform.os==='android'){
            //xApp.rotation = app.width>app.height?0:90
        }else{
            appSettings.appWidth = width
            appSettings.appX = app.x
        }
    }
    onHeightChanged:  {
        if(Qt.platform.os==='android'){
            //xApp.rotation = app.width>app.height?0:90
        }else{
            appSettings.appHeight = height
            appSettings.appY = app.y
        }
    }
    onXChanged: {
        appSettings.appX = app.x
    }
    onYChanged: {
        appSettings.appY = app.y
    }
    onVisibilityChanged: {
        appSettings.appWS = app.visibility
    }

    property int fs: Qt.platform.os !=='android'?app.width*0.02:app.width*0.03
    property color c1: "#1fbc05"
    property color c2: "#4fec35"
    property color c3: "white"
    property color c4: "black"
    property color c5: "#333333"

    property string appVigente: appName
    property string appSeleccionada: appName

    Settings{
        id: appSettings
        category: 'Configuration'+appName
        property string languaje: 'English'
        property int appWidth: 500
        property int appHeight: 500
        property int appX: 0
        property int appY: 0
        property int appWS
        property int pyLineRH1: 0
        property bool logVisible: true
        property string uGitUrl: 'https://github.com/nextsigner/unik-qml-blogger.git'
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}

    Item{
        id: xApp
        anchors.fill: parent
        Column{
            height: app.height
            Rectangle{//Top Tool Bar
                id: xTopBar
                width: app.width
                height: app.fs*1.4
                color: app.c5
                border.color: app.c4
                border.width: 1
                Rectangle{
                    width: app.fs
                    height: app.fs
                    radius: width*0.2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: app.fs
                    color: app.c5

                    Text {
                        id: userLoginIcon
                        text: "\uf2bd"
                        font.pixelSize: app.fs
                        font.family: "FontAwesome"
                        anchors.centerIn: parent
                        color: app.logueado ? app.c1 : "red"

                    }
                    Text {
                        id: userLoginId
                        text: app.userLogin
                        font.pixelSize: app.fs*0.5
                        anchors.left: userLoginIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                        color: app.c1
                        //visible: app.logueado

                    }
                    MouseArea{
                        id: maLogIcon
                        anchors.fill: parent
                        property bool p: false
                        onPressed: {
                            p = true
                            tpresslogout.start()
                        }
                        onReleased: {
                            p = false
                        }
                        onClicked: {
                            p = false
                            if(!app.logueado){
                                ful.visible = true
                            }
                        }
                        Timer{
                            id: tpresslogout
                            running: true
                            repeat: true
                            interval: 1500
                            onTriggered: {
                                if(maLogIcon.p){
                                    app.logueado = false
                                }
                            }
                        }
                    }
                }
                Text {
                    id: tit
                    text: "<b>unik-tools</b>"
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                    color: app.c1
                }
                Text {
                    id: txtAppVigente
                    text: "<b>Próximo inicio: </b>"+app.appVigente
                    font.pixelSize: app.fs
                    anchors.right: parent.right
                    anchors.rightMargin: app.fs*0.1
                    color: app.c1
                }
            }

            Row{
                id:rowAreas
                width: app.width
                height: app.height-xTopBar.height
                Rectangle{
                    id: xTools
                    width: app.fs*2
                    height: parent.height
                    color: "transparent"
                    border.color: app.c2
                    border.width: 1

                    Column{
                        id: colTools
                        width: parent.width*0.8
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing:  width*0.5
                        anchors.verticalCenter: parent.verticalCenter

                        Boton{//AppList
                            id:btnArea0
                            w:parent.width
                            h: w
                            t: '\uf022'
                            b:app.area===0?app.c2:app.c1
                            onClicking: {
                                app.area=0
                            }
                        }
                        Boton{//PageAppList
                            id:btnArea1
                            w:parent.width
                            h: w
                            t: '\uf022'
                            b:app.area===1?app.c2:app.c1
                            onClicking: {
                                app.area=1
                            }
                        }
                        Boton{//Help
                            id:btnArea2
                            w:parent.width
                            h: w
                            t: '\uf05a'
                            b:app.area===2?app.c2:app.c1
                            onClicking: {
                                app.area=2
                            }
                        }
                        Boton{//Add git project
                            id:btnAddGit
                            w:parent.width
                            h: w
                            t: '\uf09b'
                            b:app.area===1?app.c2:app.c1
                            opacity: app.area===0?1.0:0.0
                            enabled: opacity===1.0
                            onClicking: {
                                pal.dgvisible = !pal.dgvisible
                            }
                            Text {
                                text: '+'
                                font.family: "FontAwesome"
                                font.pixelSize: btnAddGit.height*0.3
                                anchors.centerIn: parent
                            }
                        }
                        Boton{//Actualizar Unik-Tools
                            id:btnUpdateUnikTools
                            w:parent.width
                            h: w
                            t: '\uf021'
                            b:app.c1
                            onClicking: {
                                var g1='https://github.com/nextsigner/unik-tools.git'
                                var g2=(''+g1[g1.length-1]).replace('.git', '')
                                var folder=unik.getPath(3)+'/unik'
                                var folder2=folder+'/'+g2
                                unik.log('Prepare urlGit: https://github.com/nextsigner/unik-tools.git')
                                unik.log('Making folder: '+folder)
                                unik.mkdir(folder2)
                                var urlGit='https://github.com/nextsigner/unik-tools'
                                var gitDownloaded=unik.downloadGit(urlGit, folder)
                                if(gitDownloaded){
                                    engine.load(folder+'/unik-tools/main.qml')
                                }
                            }
                        }
                        Boton{//Show Debug Panel
                            id:btnShowDP
                            w:parent.width
                            h: w
                            t: '\uf188'
                            b:appSettings.logVisible?app.c2:'#444'
                            c: appSettings.logVisible?'black':'#ccc'
                            opacity: app.area===1?1.0:0.0
                            enabled: opacity===1.0
                            onClicking: {
                                appSettings.logVisible = !appSettings.logVisible
                            }
                        }
                        Boton{//Quit
                            w:parent.width
                            h: w
                            t: "\uf011"
                            b:"#444444"
                            c: app.c2
                            onClicking: {
                                Qt.quit()
                            }
                        }
                    }

                }
                AppList{
                    id: appList
                    width: app.width-xTools.width
                    height: parent.height
                    visible: app.area===0
                }
                PageAppList{
                    id: pal
                    width: app.width-xTools.width
                    height: parent.height
                    visible: app.area===1
                }
                Ayuda{
                    id: ayuda
                    width: app.width-xTools.width
                    height: parent.height
                    visible: app.area===2
                }
            }




        }

        FormUnikLogin{
            id: ful
            visible: false
            width:  parent.width
            height: parent.height
            color: app.c5
        }
    }

    Timer{
        id:timerInit
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            unik.log('unik-tools log')
            unik.log('unik-tools version: '+version+'')
            unik.log('unik-tools host:  '+host+'')

        }
    }

    Component.onCompleted: {
        if(Qt.platform.os==='windows'||Qt.platform.os==='linux'||Qt.platform.os==='osx'){
            app.visibility = appSettings.appWS
            if(appSettings.appWS===2){
                app.x = appSettings.appX
                app.y = appSettings.appY
                app.width = appSettings.appWidth
                app.height = appSettings.appHeight
            }
        }else{
            app.visibility = "FullScreen"
        }
        ful.init()
        timerInit.start()
        unik.log('Unik Tools AppName: '+appName)
    }

}
