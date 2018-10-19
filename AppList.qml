import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    id: raiz
    color: app.c5
    ListView{
        id: lv
        width: raiz.width*0.9
        height: raiz.height
        spacing: app.fs*0.5
        delegate: del
        anchors.horizontalCenter: parent.horizontalCenter
        clip:true
        Component{
            id:del
            Rectangle{
                id: xC
                width: lv.width-app.fs
                height: visible?lv.width*0.2:0
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                color: app.c1
                opacity: nom!=='spacer'?1.0:0.0
                border.width: 2
                border.color: app.c2
                radius: app.fs*0.5
                visible: (''+tipo).indexOf(''+Qt.platform.os)!==-1
                Image {
                    id: imagen
                    source: img2
                    width: xC.height-app.fs*0.4
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: app.fs*0.5
                    cache:false
                }
                Column{
                    //visible:parent.color!=='transparent'
                    anchors.left: imagen.right
                    anchors.leftMargin: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        id: xNom
                        width:xC.width-imagen.width-app.fs*1.5
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
                        width:xNom.width
                        height: xC.height*0.6
                        anchors.horizontalCenter: xNom.horizontalCenter
                        clip: true
                        color: "transparent"
                        Text {
                            id: ldes
                            text: des
                            font.pixelSize: app.fs*0.6
                            anchors.centerIn: parent
                            width: parent.width-app.fs*0.8
                            wrapMode: Text.WordWrap
                        }
                    }
                    Rectangle{
                        id:xDevYBotInst
                        width:xNom.width
                        height: xC.height*0.15
                        clip: true
                        color: "transparent"
                        anchors.horizontalCenter: xNom.horizontalCenter
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
                                    if((''+urlgit).indexOf('.upk')<0){
                                        var carpetaLocal=appsDir
                                        //console.log('Descargando  '+urlgit)
                                        //var downloaded = unik.downloadGit(urlgit, carpetaLocal)
                                        var fd = appsDir
                                        var m0= (''+urlgit).split('/')
                                            var s0=''+m0[m0.length-1]
                                            var s1=s0.replace('.git', '')
                                            //var nc = '{"mode":"-folder", "arg1": "'+fd+'/'+s1+'"}'
											var nct = '{"mode":"-git", "arg1": "'+urlgit+'"}'
                                            var nct2 = ('{"arg0":"-git='+urlgit+'.git", "arg1":"-dir='+appsDir+'/'+s1+'"}').replace('.git.git', '.git')
                                        console.log("NCT2: "+nct2)
                                        unik.setFile(appsDir+'/temp_cfg.json', nct2)
                                        unik.setFile(appsDir+'/temp_config.json', nct)
                                        unik.restartApp()
                                    }else{
                                        var m0=(''+urlgit).split('/')
                                        var m1=''+m0[m0.length-1]
                                        var upkData=unik.getHttpFile(urlgit)
                                        var upkFileName=appsDir+'/'+m1
                                        unik.setFile(upkFileName, upkData)
                                        var c='{"mode":"-upk", "arg1": "'+upkFileName+'", "arg2":"-user=unik-free", "arg3":"-key=free"}'
                                        unik.setFile(appsDir+'/config.json', c)
                                        unik.restartApp()

                                    }


                                }
                            }

                        }
                    }
                }
            }
        }
    }


    Rectangle{
        width: txtEstado.contentWidth*1.2
        height: txtEstado.contentHeight*1.2
        color: app.c5
        border.width: 2
        border.color: app.c2
        radius: app.fs
        anchors.centerIn: raiz
        visible: lv.model.count<1

        Text{
            id:txtEstado
            font.pixelSize: app.fs
            anchors.centerIn: parent
            color: app.c2
            text: '<b>Cargando lista de aplicaciones...</b>'
        }
        MouseArea{
            anchors.fill: parent
            onClicked: act()
        }
    }
    function act(){
        var d = new Date(Date.now())
        var dm1='The document has moved'
        var c = ''+unik.getHttpFile('https://nsdocs.blogspot.com.ar/p/app-list.html')
        if(c.indexOf(dm1)>0){
            console.log('Reading AppList for Unik Qml Engine from www.unikode.org')
            c = ''+unik.getHttpFile('http://www.unikode.org/p/app-list.html')
        }else{
            console.log('Reading AppList for Unik Qml Engine from blogpots.com.ar')
        }
        //console.log(c)
        var m0=c.split('item="tit"')
        var s0=''+m0[1]
        var m1=s0.split('item="pie"')
        var s1=''+m1[0]
        var m2=s1.split('item="item">')

        var nlm='import QtQuick 2.0\n'
        nlm+='ListModel{\n'

        for(var i=1;i<m2.length;i++){
            //console.log('-------->'+m2[i])
            var ss0=''+m2[i]
            var mm0=ss0.split("</h2>")
            var nom=''+mm0[0]



            var mm1=ss0.split("src=\"")
            var mm2=(''+mm1[1]).split("\"")
            var img=''+mm2[0]

            var mm3=ss0.split("<div>")
            var mm4=(''+mm3[1]).split('<h5 item="url"')
            var ss1=(''+mm4[0]).replace(/<br \/>/g,'')
            var des=''+ss1.replace(/<\/div>/g,'')

            var mm5=ss0.split('<h5 item="url">')
            var mm6=(''+mm5[1]).split('href=\"')
            var mm7=(''+mm6[1]).split('\"')
            var urlGit=''+mm7[0]

            var mm8=ss0.split("</h4>")
            var mm9=(''+mm8[0]).split('con: ')
            var mm10=(''+mm9[0]).split('Autor: ')
            var mm11=(''+mm10[1]).split(' - ')
            var comp=''+mm9[1]
            var autor=''+mm11[0]


//            console.log('Nombre: '+nom)
//            console.log('Img: '+img)
//            console.log('Des: '+des)
//            console.log('UrlGit: '+urlGit)
//            console.log('Comp: '+comp)
//            console.log('Autor: '+autor)


            nlm+='ListElement{
            nom: "'+nom+'"
            des: "'+des+'"
            dev: "'+autor+'"
            urlgit: "'+urlGit+'"
            img2: "'+img+'"
            tipo: "'+comp+'"
        }'

        }
        nlm+='ListElement{nom: "spacer";des:"";dev:"";img2:"";tipo: "linux-osx-windows-android"}'
        nlm+='}\n'
        var nLm=Qt.createQmlObject(nlm, raiz, 'qmlNLM')
        lv.model = nLm
        txtEstado.text= '<b>Error</b> Fallò la conexiòn o descarga de lista.<br>Click para Actualizar lista de Aplicaciones.'


    }

}
