import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0


Rectangle{
    id: raiz
    color: 'transparent'
    signal loginEvent(bool l)
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
                text: '<b>Usuario o Correo:</b>'
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
                    KeyNavigation.tab: tiSetKey
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
                text: '<b>Clave:</b>'
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
                    echoMode: TextInput.Password
                    KeyNavigation.tab: botCancelar
                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.preferredWidth: appRoot.width*0.8
            Layout.minimumHeight:  appRoot.fs
            spacing: 0
            CheckBox{
                id: recordarme
                width: appRoot.fs
                height: appRoot.fs
            }

            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: appRoot.fs
            }
            Button{
                id: botCancelar
                Layout.preferredWidth: appRoot.fs*6
                Layout.preferredHeight: 50
                font.pixelSize: appRoot.fs*0.8
                background: Rectangle{color:parent.p ? appRoot.c1 : appRoot.c2;}
                text: p ? '<b>Cancelar</b>' : 'Cancelar'
                property bool p: false
                onPressed: {
                    p = true
                }
                onReleased: {
                    p = false
                }
                onClicked: {
                    appRoot.logueado = false
                    raiz.visible = false
                }
                KeyNavigation.tab: botAceptar
                Keys.onReturnPressed: {
                    appRoot.logueado = false
                    raiz.visible = false
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.maximumWidth: appRoot.fs
                Layout.preferredHeight: appRoot.fs
            }
            Button{
                id: botAceptar
                Layout.preferredWidth: appRoot.fs*6
                Layout.preferredHeight: 50
                font.pixelSize: appRoot.fs*0.8
                background: Rectangle{color:parent.p ? appRoot.c1 : appRoot.c2;}
                text: p ? '<b>Login</b>' : 'Login'
                property bool p: false
                onPressed: {
                    p = true
                }
                onReleased: {
                    p = false
                }
                onClicked: {
                    loguin(tiSetUser.text, tiSetKey.text, true)
                }
                KeyNavigation.tab: tiSetUser
                Keys.onReturnPressed: {
                    loguin(tiSetUser.text, tiSetKey.text, true)
                }

            }
        }
    }

    function loguin(u, k, reset){
        if(u!==''){
            var passFile = uk.getPath(4)+'/pass'
            var url =  host+'/modulos/login.php?email='+u+'&clave='+k
            var ret = parseInt(uk.getHttpFile(url))
            //console.log("Url Login: "+url)
            //console.log("Ret: "+ret)
            if(ret===-1){
                appRoot.userLogin = ""
                //console.log('Usuario no existente')
                taLog.log('Login não é bem sucedido! / Login no se ha producido con èxito! / Login is not successful!')
                taLog.log('Login
devido a falha em nome de usuário e senha / Login falla por error en usuario y clave incorrectas / Login fail in user and password data.')
            }else if(ret>0){
                //console.log('Logueado!')
                taLog.log('Login é bem sucedido! / Login se ha producido con èxito! / Login is successful!')
                appRoot.logueado = true
                raiz.visible = false
                appRoot.userLogin = u
                if(recordarme.checked){
                    //qkey.encriptar(tiSetUser.text+'@@@'+tiSetKey.text)
                    var passEnc = uk.encData(u+','+k, 'au', 'ak')
                    //console.log("Enc Pass: "+passEnc)

                    //console.log("passFile: "+passFile)
                    uk.setFile(passFile, passEnc)
                    //console.log('DecPass: '+uk.decData(uk.getFile(passFile), tiSetUser.text, tiSetKey.text))
                }else{
                    if(reset){
                        uk.setFile(passFile, '')
                    }
                }
            }else if(ret===-2){
                appRoot.userLogin = ""
                console.log('Error de clave de acceso')
                taLog.log('Login não é bem sucedido! / Login no se ha producido con èxito! / Login is not successful!')

            }else{
                appRoot.userLogin = ""
                console.log('Error al loguear: Estado desconocido')
                taLog.log('Login não é bem sucedido! / Login no se ha producido con èxito! / Login is not successful!')
                taLog.log('Login
devido a falha em nome de usuário e senha / Login falla por error en usuario y clave incorrectas / Login fail in user and password data.')
            }
        }
    }
    function init() {
        var passFile = uk.getPath(4)+'/pass'
        var dataPass = uk.decData(uk.getFile(passFile), 'au', 'ak')
        //console.log('DecPass: '+
        if(dataPass!==''){
            var m0 = (''+dataPass).split(',')
            console.log('User R: '+m0[0])
            console.log('Key R: '+m0[1])
            loguin(m0[0], m0[1], false)
        }else{
            taLog.log('unik-tools não é login / unik-tools no està logueado / unik-tools is not login')
        }
    }
}

