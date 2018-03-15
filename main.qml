import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

ApplicationWindow{
    id: app
    visible: true
    width: 500
    height: 500
    title: "unik-tools"
    color: Qt.platform.os !=='android' && app.waiting?"transparent":app.c5
    minimumWidth: 500
    minimumHeight: 500

    property int area: 0
    property bool closedModeLaunch: false
    property bool logueado: false
    property string userLogin: ''
    property string keyLog: ''
    property bool waiting: wait

    flags: Qt.platform.os !=='android' && app.waiting?Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint:1

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
        category: 'conf-unik-tools'
        property string languaje: 'English'
        property int appWidth: 500
        property int appHeight: 500
        property int appX: 0
        property int appY: 0
        property int appWS
        property int pyLineRH1: 0
        property bool logVisible: true
        property string uGitUrl: 'https://github.com/nextsigner/unik-qml-blogger.git'
        property string uRS
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Item{
        id: xWainting
        anchors.fill: parent
        visible: app.waiting
        Rectangle{
            width: parent.width*0.1
            height: width
            radius: width*0.5
            color: app.c5
            border.width: 2
            border.color: app.c2
            anchors.centerIn: parent
            Text {
                id: txtW0
                text: "\uf1ce"
                font.family: "FontAwesome"
                color: app.c2
                font.pixelSize: parent.width*0.9
                anchors.centerIn: parent
                onRotationChanged:{if(rotation>279){rotation=50}}
                Behavior on rotation {
                    NumberAnimation {
                        target: txtW0
                        property: "rotation"
                        duration: 2000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Text {
                id: txtW1
                text: "\uf1ce"
                font.family: "FontAwesome"
                color: "black"
                rotation: 100
                font.pixelSize: parent.width*0.8
                anchors.centerIn: parent
                onRotationChanged:{if(rotation>330){rotation=180}}
                Behavior on rotation {
                    NumberAnimation {
                        target: txtW1
                        property: "rotation"
                        duration: 3000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Text {
                id: txtW2
                text: "\uf1ce"
                font.family: "FontAwesome"
                color: app.c2
                rotation: 350
                font.pixelSize: parent.width*0.7
                anchors.centerIn: parent
                onRotationChanged:{if(rotation<180){rotation=300}}
                Behavior on rotation {
                    NumberAnimation {
                        target: txtW2
                        property: "rotation"
                        duration: 5000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Text {
                id: txtWaiting1
                text: "?"
                font.family: "FontAwesome"
                color: app.c2
                font.pixelSize: parent.width*0.55
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: app.waiting=false
            }
        }
        Timer{
            id:tw
            running: true
            repeat: true
            interval: 1000
            property int s: 5
            onTriggered: {
                txtWaiting1.text=''+s
                //console.log("--------------------->"+s)
                if(s===0){
                    tw.stop()
                    if(app.waiting){
                        Qt.quit()
                    }
                }
                txtWaiting1.opacity=txtWaiting1.opacity-=0.15
                tw.s--
            }
        }

    }
    Item{
        id: xApp
        anchors.fill: parent
        visible: !app.waiting
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
                        spacing:  Qt.platform.os !=='android'?width*0.5:width*0.25
                        anchors.verticalCenter: parent.verticalCenter

                        Boton{//AppList
                            id:btnArea0
                            w:parent.width
                            h: w
                            t: '\uf0ca'
                            b:app.area===0?app.c2:app.c1
                            //f: 'FontAwesome'
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
                        /*Boton{//Load QML
                            id:btnLoadQml
                            visible: userLogin==='nextsigner@gmail.com'
                            w:parent.width
                            h: w
                            t: '\uf05a'
                            b:app.c1
                            onClicking: {
                                unik.loadQml('dfsdf')
                            }
                        }*/
                        Boton{//Add git project
                            id:btnAddGit
                            w:parent.width
                            h: w
                            t: '\uf09b'
                            b:pal.dgvisible?app.c2:app.c5
                            c:pal.dgvisible?app.c5:app.c2
                            onClicking: {
                                app.area = 1
                                pal.dgvisible = !pal.dgvisible
                            }
                            Text {
                                text: '+'
                                font.family: "FontAwesome"
                                font.pixelSize: btnAddGit.height*0.3
                                anchors.centerIn: parent
                                color: btnAddGit.c
                            }
                        }
                        Boton{//Actualizar Unik-Tools
                            id:btnUpdate
                            w:parent.width
                            h: w
                            t: '\uf021'
                            b: up ? 'red':app.c1
                            c: up ? 'white':'#000'
                            property bool up: false
                            onClicking: {
                                if(!up){
                                    unik.restartApp("-git=https://github.com/nextsigner/unik-tools.git")
                                }else{
                                    var args = '-folder '+unik.getPath(3)+'/unik/unik-tools'
                                    args += ' -dim='+app.width+'x'+app.height+' -pos='+app.x+'x'+app.y
                                    if(Qt.platform.os!=='android'){
                                        unik.restartApp(args)
                                    }else{
                                        var gitDownloaded=unik.downloadGit('https://github.com/nextsigner/unik-tools', unik.getPath(3)+'/unik/unik-tools')
                                        if(gitDownloaded){
                                            var j=unik.getPath(3)+'/unik/temp_config.json'
                                            var c='{"mode":"-folder", "arg1": "'+unik.getPath(3)+'/unik/unik-tools'+'"}'
                                            unik.setFile(j, c)
                                            unik.restartApp()
                                        }
                                    }
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
                        Boton{//Restart
                            w:parent.width
                            h: w
                            t: '\uf021'
                            b:"#444444"
                            c: app.c1
                            onClicking: {
                                unik.restartApp()
                            }
                            Text {
                                text: "\uf011"
                                font.family: "FontAwesome"
                                font.pixelSize: btnAddGit.height*0.3
                                anchors.centerIn: parent
                                color: app.c2
                            }
                        }
                        Boton{//Quit
                            w:parent.width
                            h: w
                            t: "\uf011"
                            b:"#444444"
                            c: app.c1
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

    Timer{
        id:tu
        running: true
        repeat: true
        //interval: 1000*60*60
        interval: 1000*3
        onTriggered: {
            var d = new Date(Date.now())
            unik.setDebugLog(false)
            var ur0 = ''+unik.getHttpFile('https://github.com/nextsigner/unik-tools/commits/master?r='+d.getTime())
            var m0=ur0.split("commit-title")
            var m1=(''+m0[1]).split('</p>')
            var m2=(''+m1[0]).split('\">')
            var m3=(''+m2[1]).split('\"')
            var ur = ''+m3[1]
            //unik.log("Update key control: "+ur)
            if(appSettings.uRS!==''&&appSettings.uRS!==ur){
                unik.setDebugLog(true)
                unik.log("Updating unik-tools")
                appSettings.uRS = ur
                var fd=unik.getPath(3)+'/unik'
                var downloaded = unik.downloadGit('https://github.com/nextsigner/unik-tools', fd)
                appSettings.uRS=''
                tu.stop()
                if(downloaded){
                    btnUpdate.up=true
                }else{
                    tu.start()
                }
            }else{
                appSettings.uRS=ur
            }
            unik.setDebugLog(true)
        }
    }

    Component.onCompleted: {
        txtW0.rotation= txtW0.rotation+280
        txtW1.rotation= txtW1.rotation-340
        txtW2.rotation= 170
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
        appList.act()
    }

}
