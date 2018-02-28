import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import uk 1.0

ApplicationWindow{
    id: app
    visible: true
    width: 640
    height: 480
    title: qsTr("uniK-Tools")
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
        console.log("Cerrando en closedModeLaunch: "+closedModeLaunch)
    }

    property int fs: app.width*0.02
    property color c1: "#1fbc05"
    property color c2: "#4fec35"
    property color c3: "white"
    property color c4: "black"
    property color c5: "#333333"


    property string appVigente: appName
    property string appSeleccionada: appName


    //color: c5

    UK{
        id:uk
        onPorcChanged: {
            console.log("Descargando: "+porc)
        }
    }
    Connections {
        target: uk
        onUkStdChanged: {
            unik.log(uk.ukStd)
        }
    }
    Settings{
        id: appSettings
        category: 'Configuration'
        property int pyLineRH1: 0
        property bool logVisible: false
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Rectangle{
        id: fondoApp
        width: parent.width
        height: parent.height-app.fs*1.4
        //color: "transparent"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: app.c5;
            }
            GradientStop {
                position: 0.99;
                color: app.c5;
            }
            GradientStop {
                position: 1.00;
                color: app.c1;
            }
        }
    }
    Item{
        id: x
        anchors.fill: parent
        Column{
            height: app.height
            Rectangle{
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
                id: rowAreas
                width: app.width*children.length
                //height: tabBar.currentIndex===0? app.height-app.fs*2.8-app.fs*4 : app.height-app.fs*2.8
                height: app.height-app.fs*2.8
                x:0-(tabBar.currentIndex*app.width)
                Behavior on x{
                    NumberAnimation{
                        duration: 500
                        easing.type: Easing.OutQuad
                    }
                }
                PageAppList{
                    id: pal
                    width: app.width
                    height: parent.height
                }
                Ayuda{
                    id: ayuda
                    width: app.width
                    height: parent.height
                }
            }



            TabBar {
                id: tabBar
                width: app.width
                height: app.fs*1.4
                //anchors.top: rowAreas.bottom

                //currentIndex: swipeView.currentIndex
                background: Rectangle{color:"transparent";}
                onCurrentIndexChanged: {
                    if(currentIndex===count-1){
                        Qt.quit()
                    }
                }
                TabButton {
                    id: tb1
                    text: qsTr("Lista de Apps")
                    font.pixelSize: app.fs
                    focus: tabBar.currentIndex===0
                    onFocusChanged: {
                        if(focus){
                            background.color = app.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = app.c2
                    }
                    onReleased: {
                        background.color = app.c2
                    }
                }
                TabButton {
                    text: qsTr("Ayuda")
                    font.pixelSize: app.fs
                    focus: tabBar.currentIndex===2
                    onFocusChanged: {
                        if(focus){
                            background.color = app.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = app.c2
                    }
                    onReleased: {
                        background.color = app.c2
                    }
                }
                TabButton {
                    text: qsTr("Salir")
                    font.pixelSize: app.fs
                    focus: tabBar.currentIndex===3
                    onFocusChanged: {
                        if(focus){
                            background.color = app.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = app.c2
                    }
                    onReleased: {
                        background.color = app.c2
                    }
                }
            }
        }

        FormUnikLogin{
            id: ful
            visible: false
            width:  parent.width
            height: parent.height-tabBar.height
            color: app.c5
        }
    }
    Timer{
        id:timerInit
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            unik.log('<b>unik-tools log</b>')
            unik.log('<b>unik-tools version:</b> '+version+'')
            unik.log('<b>unik-tools host:</b> '+host+'')

        }
    }

    Component.onCompleted: {
        if(Qt.platform.os==='windows'||Qt.platform.os==='linux'){
            app.visibility = "Maximized"
        }
        ful.init()
        timerInit.start()
    }

}
