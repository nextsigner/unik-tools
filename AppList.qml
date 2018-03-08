import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    id: raiz
    color: app.c5

    ListView{
        id: lv
        width: raiz.width*0.96
        height: raiz.height
        anchors.horizontalCenter: raiz.horizontalCenter
        model: lm
        delegate: del
        ListModel{
            id:lm
            ListElement{
                nom: "RickyPapi Web Browser"
                des: "Navegador Web para Los Rickytos de Matias Ponce. Este navegador está diseñado solo para navegar por las Redes Sociales más importantes de la manera más facil, ágil y dinámica aprovechando al máximo tu pantalla."
                dev: "@nextsigner"
                urlgit: "https://github.com/nextsigner/rickypapi"
                img2: "https://github.com/nextsigner/rickypapi/blob/master/unik_rickypapi_1.PNG?raw=true"
            }

        }
        Component{
            id:del
            Rectangle{
                id: xC
                width: lv.width
                height: lv.width*0.2
                clip: true
                color: app.c1
                border.width: 2
                border.color: app.c2
                radius: app.fs*0.5
                Image {
                    id: imagen
                    source: img2
                    width: xC.height-app.fs*0.2
                    height: width*0.6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: app.fs*0.1
                }
                Column{
                    anchors.left: imagen.right
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        id: xNom
                        width:xC.width-imagen.width-xC.width*0.02
                        height: xC.height*0.15
                        clip: true
                        color: "transparent"
                        Text {
                            id: lnom
                            text: '<b>'+nom+'</b>'
                            font.pixelSize: app.fs
                            width: parent.width-app.fs
                            anchors.centerIn: parent
                        }
                    }
                    Rectangle{
                        id:xDes
                        width:xC.width-imagen.width-xC.width*0.02
                        height: xC.height*0.6
                        clip: true
                        color: "transparent"
                        Text {
                            id: ldes
                            text: des
                            font.pixelSize: app.fs
                            anchors.centerIn: parent
                            width: parent.width-app.fs*0.8
                            wrapMode: Text.WordWrap
                        }
                    }
                    Rectangle{
                        id:xDevYBotInst
                        width:xC.width-imagen.width-xC.width*0.02
                        height: xC.height*0.15
                        clip: true
                        color: "transparent"
                        Text {
                            id: ldev
                            text: '<b>Desarrollador: </b>'+dev+''
                            font.pixelSize: app.fs*0.8
                            width: contentWidth+app.fs
                            anchors.left: parent.left
                            anchors.leftMargin: app.fs*0.5
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            id:botInstalarApp
                            width:lBotInst.contentWidth+app.fs
                            height: xC.height*0.15
                            clip: true
                            color: 'black'
                            anchors.right: parent.right
                            radius: app.fs*0.5
                            Text {
                                id: lBotInst
                                color: app.c2
                                text: "Instalar"
                                font.pixelSize: app.fs*0.8
                                anchors.centerIn: parent
                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    botInstalarApp.color = app.c2
                                    lBotInst.color = 'black'
                                }
                                onExited:  {
                                    botInstalarApp.color = 'black'
                                    lBotInst.color = app.c2
                                }
                                onPressed: {
                                    lBotInst.text='<b>'+"Instalar"+'</b>'
                                }
                                onReleased: {
                                    lBotInst.text="Instalar"
                                }
                                onClicked: {
                                    app.area=1
                                    var fd = unik.getPath(3)+'/unik'
                                    var downloaded = unik.downloadGit(urlgit, fd)
                                    if(downloaded){
                                        unik.log('Aplicación '+nom+' descargada.')
                                        var m0= (''+urlgit).split('/')
                                        var s0=''+m0[m0.length-1]
                                        var s1=s0.replace('.git', '')
                                        var nc = '{"mode":"-folder", "arg1": "'+fd+'/'+s1+'"}'
                                        unik.setFile(unik.getPath(3)+'/unik/config.json', nc)
                                        unik.restartApp()
                                    }else{
                                        unik.log('Aplicación '+nom+' no se ha instalado.')
                                    }


                                }
                            }

                        }
                    }
                }


            }
        }
    }



}
