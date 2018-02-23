import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
//import QtQuick.Controls.Styles 1.4
import uk 1.0

ApplicationWindow{
    id: appRoot
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
            appRoot.close()
        }
    }
    onClosing: {
        console.log("Cerrando en closedModeLaunch: "+closedModeLaunch)
    }

    property int fs: appRoot.width*0.02
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
            taLog.log(uk.ukStd)
        }
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Rectangle{
        id: fondoApp
        width: parent.width
        height: parent.height-appRoot.fs*1.4
        //color: "transparent"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: appRoot.c5;
            }
            GradientStop {
                position: 0.99;
                color: appRoot.c5;
            }
            GradientStop {
                position: 1.00;
                color: appRoot.c1;
            }
        }
    }
    Item{
        id: x
        anchors.fill: parent
        Column{
            height: appRoot.height
            Rectangle{
                width: appRoot.width
                height: appRoot.fs*1.4
                color: appRoot.c5
                border.color: appRoot.c4
                border.width: 1
                Rectangle{
                    width: appRoot.fs
                    height: appRoot.fs
                    radius: width*0.2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appRoot.fs
                    color: appRoot.c5

                    Text {
                        id: userLoginIcon
                        text: "\uf2bd"
                        font.pixelSize: appRoot.fs
                        anchors.centerIn: parent
                        color: appRoot.logueado ? appRoot.c1 : "red"

                    }
                    Text {
                        id: userLoginId
                        text: appRoot.userLogin
                        font.pixelSize: appRoot.fs*0.5
                        anchors.left: userLoginIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                        color: appRoot.c1
                        //visible: appRoot.logueado

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
                            if(!appRoot.logueado){
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
                                    appRoot.logueado = false
                                }
                            }
                        }
                    }
                }
                Text {
                    id: tit
                    text: "<b>unik-tools</b>"
                    font.pixelSize: appRoot.fs
                    anchors.centerIn: parent
                    color: appRoot.c1
                }
                Text {
                    id: txtAppVigente
                    text: "<b>Próximo inicio: </b>"+appRoot.appVigente
                    font.pixelSize: appRoot.fs
                    anchors.right: parent.right
                    anchors.rightMargin: appRoot.fs*0.1
                    color: appRoot.c1
                }
            }
            Row{
                id: rowAreas
                width: appRoot.width*children.length
                height: appRoot.height-appRoot.fs*2.8-appRoot.fs*4
                x:0-(tabBar.currentIndex*appRoot.width)
                Behavior on x{
                    NumberAnimation{
                        duration: 500
                        easing.type: Easing.OutQuad
                    }
                }
                PageAppList{
                    id: pal
                    width: appRoot.width
                    height: parent.height
                }
                Page1 {
                    width: appRoot.width
                    height: parent.height
                }
                Ayuda{
                    id: ayuda
                    width: appRoot.width
                    height: parent.height
                }
            }



            Rectangle{
                id:xTaLog
                width: appRoot.width
                height: appRoot.fs*4
                clip: true
                color: appRoot.c5
                border.width: 1
                border.color: appRoot.c2
                Flickable{
                    id:fk
                    width: parent.width
                    height: parent.height
                    contentWidth: parent.width
                    contentHeight: taLog.contentHeight
                    boundsBehavior: Flickable.StopAtBounds
                    onContentHeightChanged: {
                        //fk.contentY = fk.contentHeight
                    }
                    Text{
                        id: taLog
                        width: parent.width-appRoot.fs
                        //height: contentHeight
                        anchors.centerIn: parent
                        font.pixelSize: appRoot.fs*0.5
                        textFormat: Text.RichText
                        color: appRoot.c2
                        wrapMode: Text.WrapAnywhere
                        onTextChanged: {
                            //height = contentHeight
                        }

                        function log(l){
                            var d = new Date(Date.now())
                            var t = '['+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()+'] '
                            taLog.text+=t+l+'<br />'
                            if(taLog.height>xTaLog.height){
                                //fk.contentY += appRoot.fs*0.525
                                fk.contentY = taLog.height-xTaLog.height
                            }else{
                                //fk.contentY = 1111
                            }
                        }
                    }
                }

            }

                        TabBar {
                id: tabBar
                width: appRoot.width
                height: appRoot.fs*1.4
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
                    font.pixelSize: appRoot.fs
                    focus: tabBar.currentIndex===0
                    onFocusChanged: {
                        if(focus){
                            background.color = appRoot.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = appRoot.c2
                    }
                    onReleased: {
                        background.color = appRoot.c2
                    }
                }
                TabButton {
                    text: qsTr("Instalar Apps")
                    font.pixelSize: appRoot.fs
                    focus: tabBar.currentIndex===1
                    onFocusChanged: {
                        if(focus){
                            background.color = appRoot.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = appRoot.c2
                    }
                    onReleased: {
                        background.color = appRoot.c2
                    }
                }
                TabButton {
                    text: qsTr("Ayuda")
                    font.pixelSize: appRoot.fs
                    focus: tabBar.currentIndex===2
                    onFocusChanged: {
                        if(focus){
                            background.color = appRoot.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = appRoot.c2
                    }
                    onReleased: {
                        background.color = appRoot.c2
                    }
                }
                TabButton {
                    text: qsTr("Salir")
                    font.pixelSize: appRoot.fs
                    focus: tabBar.currentIndex===3
                    onFocusChanged: {
                        if(focus){
                            background.color = appRoot.c2
                        }else{
                            background.color = "#444444"
                        }
                    }
                    onPressed: {
                        background.color = appRoot.c2
                    }
                    onReleased: {
                        background.color = appRoot.c2
                    }
                }
            }
        }

        FormUnikLogin{
            id: ful
            visible: false
            width:  parent.width
            height: parent.height-xTaLog.height-tabBar.height
            color: appRoot.c5
        }
    }




    Timer{
        id:timerInit
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            taLog.log('<b>unik-tools log</b>')
            taLog.log('<b>unik-tools version:</b> '+version+'')
            taLog.log('<b>unik-tools host:</b> '+host+'')

        }
    }

    Component.onCompleted: {
        if(Qt.platform.os==='windows'||Qt.platform.os==='linux'){
            appRoot.visibility = "Maximized"
        }
        ful.init()
        timerInit.start()
    }

}
