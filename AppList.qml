import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    id: raiz
    color: app.c5
    signal loaded
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
                    //width:
                    height: xC.height-app.fs*0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: app.fs*0.5
                    //cache:false
                    fillMode: Image.PreserveAspectFit
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
                                        var nclink
                                        if(Qt.platform.os==='linux'){
                                            var nct2
                                            if(''+s1==='unikast'){
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg -wss'
                                                nct2 = '{"arg0":"-git='+urlgit+'.git", "arg1":"-folder='+appsDir+'/'+s1+'", "arg2":"-cfg", "arg3":"-wss"}'
                                                unik.createLink(appExec+' -folder='+appsDir+'/'+s1+' -cfg -wss', unik.getPath(6)+'/'+s1+'.desktop', s1, 'It is created by Unik Qml Engine with the UnikTools')
                                                unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                                unik.setFile(appsDir+'/temp_cfg.json', nct2)
                                                 unik.ejecutarLineaDeComandoAparte(appExec+' -git='+urlgit+' -folder='+appsDir+'/'+s1+'  -cfg -wss')
                                            }else{
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg'
                                                nct2 = '{"arg0":"-git='+urlgit+'.git", "arg1":"-folder='+appsDir+'/'+s1+'", "arg2":"-cfg"}'
                                                unik.createLink(appExec+' -folder='+appsDir+'/'+s1+' -cfg', unik.getPath(6)+'/'+s1+'.desktop', s1, 'It is created by Unik Qml Engine with the UnikTools')
                                                unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                                unik.setFile(appsDir+'/temp_cfg.json', nct2)
                                                 unik.ejecutarLineaDeComandoAparte(appExec+' -git='+urlgit+' -folder='+appsDir+'/'+s1+'  -cfg')
                                            }

                                        }else if(Qt.platform.os==='osx'){
                                            nct2
                                            if(''+s1==='unikast'){
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg -wss'
                                                nct2 = '{"arg0":"-git='+urlgit+'.git", "arg1":"-folder='+appsDir+'/'+s1+'", "arg2":"-cfg", "arg3":"-wss"}'

                                                unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                                unik.setFile(appsDir+'/temp_cfg.json', nct2)
                                                unik.ejecutarLineaDeComandoAparte(appExec+' -git='+urlgit+' -folder='+appsDir+'/'+s1+'  -cfg -wss')
                                            }else{
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg'
                                                nct2 = '{"arg0":"-git='+urlgit+'.git", "arg1":"-folder='+appsDir+'/'+s1+'", "arg2":"-cfg"}'

                                                unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                                unik.setFile(appsDir+'/temp_cfg.json', nct2)
                                                unik.ejecutarLineaDeComandoAparte(appExec+' -git='+urlgit+' -folder='+appsDir+'/'+s1+'  -cfg')
                                            }
                                        }else if(Qt.platform.os==='windows'){
                                            var nct2
                                            if(''+s1==='unikast'){
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg -wss'
                                                nct2 = '{"arg0":"-git='+urlgit+'.git", "arg1":"-folder='+appsDir+'/'+s1+'", "arg2":"-wss"}'
                                                unik.createLink(appExec, '-folder='+appsDir+'/'+s1+' -cfg', unik.getPath(6)+'/'+s1+'.lnk',"It is a file created by Unik Qml Engine", appsDir+'/'+s1 )
                                                unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                                unik.ejecutarLineaDeComandoAparte(appExec+' -git='+urlgit+' -folder='+appsDir+'/'+s1+'  -cfg -wss')
                                            }else{
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg'
                                                nct2 = '{"arg0":"-git='+urlgit+'.git", "arg1":"-folder='+appsDir+'/'+s1+'"}'
                                                unik.createLink(appExec, '-folder='+appsDir+'/'+s1+' -cfg', unik.getPath(6)+'/'+s1+'.lnk',"It is a file created by Unik Qml Engine", appsDir+'/'+s1 )
                                                unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                                unik.ejecutarLineaDeComandoAparte(appExec+' -git='+urlgit+' -folder='+appsDir+'/'+s1+'  -cfg')
                                            }

                                            //unik.setFile(appsDir+'/temp_cfg.json', nct2)

                                        }else{
                                            var nct3                                            
                                            if(''+s1==='unikast'){
                                                nct3 = '{"arg0":"-folder='+appsDir+'/'+s1+'", "arg1":"-wss"}'
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg -wss'
                                                if(Qt.platform.os==='windows'){
                                                    unik.createLink(appExec, '-folder='+appsDir+'/'+s1+' -cfg -wss', unik.getPath(6)+'/'+s1+'.lnk',"It is a file created by Unik Qml Engine", appsDir+'/'+s1 )
                                                }
                                            }else{
                                                nct3 = '{"arg0":"-folder='+appsDir+'/'+s1+'"}'
                                                nclink = '-folder='+appsDir+'/'+s1+' -cfg'

                                            }
                                            unik.setFile(appsDir+'/link_'+s1+'.ukl', nclink)
                                            unik.setFile(appsDir+'/temp_cfg.json', nct3)
                                            var downloaded=unik.downloadGit(urlgit, appsDir+'/'+s1)
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
                                            var codeMsg='import QtQuick 2.0\n'
                                            codeMsg+='import QtQuick.Controls 2.0\n'
                                            codeMsg+='import QtQuick.Window 2.0\n'
                                            codeMsg+='ApplicationWindow{\n'
                                            codeMsg+='  id:winmsg\n'
                                            codeMsg+='  visible:true\n'
                                            codeMsg+='  flags:Qt.Window | Qt.WindowStaysOnTopHint\n'
                                            codeMsg+='  color:"'+app.c4+'"\n'
                                            codeMsg+='  width:txt.contentWidth+'+parseInt(app.fs)+'*6\n'
                                            codeMsg+='  height:txt.contentHeight+'+parseInt(app.fs)+'*16\n'
                                            codeMsg+='  Text{\n'
                                            codeMsg+='      id:txt\n'
                                            codeMsg+='      color:"'+app.c2+'"\n'
                                            codeMsg+='      text:"Aplicación '+s1+' Instalada\\nSe ha creado un\\nEnlace en el Escritorio."\n'
                                            codeMsg+='      font.pixelSize:'+parseInt(app.fs)+'\n'
                                            codeMsg+='      anchors.centerIn: parent\n'
                                            codeMsg+='      width:+'+parseInt(app.fs)+'*10\n'
                                            codeMsg+='      wrapMode: Text.WordWrap\n'
                                            codeMsg+='  }\n'

                                            codeMsg+='  Button{\n'
                                            codeMsg+='      id:btn\n'
                                            codeMsg+='      text:"Ejecutar"\n'
                                            codeMsg+='      font.pixelSize:'+parseInt(app.fs)+'\n'
                                            codeMsg+='      anchors.horizontalCenter: parent.horizontalCenter\n'
                                            codeMsg+='      anchors.bottom: parent.bottom\n'
                                            codeMsg+='      anchors.bottomMargin: '+parseInt(app.fs)+'\n'
                                            codeMsg+='      onClicked:{\n'
                                            codeMsg+='         unik.setFile(\''+appsDir+'/temp_cfg.json\''+', \''+nct3+'\')\n'
                                            codeMsg+='         winmsg.close()\n'
                                            codeMsg+='         unik.ejecutarLineaDeComandoAparte(\''+appPath+' -cfg\')\n'
                                            codeMsg+='      }\n'
                                            codeMsg+='  }\n'

                                            codeMsg+='      Component.onCompleted:{\n'
                                            //codeMsg+='          var d=unik.downloadGit(\''+urlgit+'\',"C:/Users/qt/Desktop/")\n'
                                            codeMsg+='      }\n'


                                            codeMsg+='}\n'
                                            unik.setFile(unik.getPath(2)+'/main.qml', codeMsg)
                                            unik.ejecutarLineaDeComandoAparte(appExec+' -folder='+unik.getPath(2)+' -cfg')
                                        }
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
        var s0
        if(m0.length>1){
            s0=''+m0[1]


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
                if(mm1.length>1){
                    var mm2=(''+mm1[1]).split("\"")
                    var img=''+mm2[0]

                    var mm3=ss0.split("<div>")


                    if(mm3.length>1){
                        var mm4=(''+mm3[1]).split('<h5 item="url"')
                        var ss1=(''+mm4[0]).replace(/<br \/>/g,'')
                        var des=''+ss1.replace(/<\/div>/g,'')

                        var mm5=ss0.split('<h5 item="url">')
                        if(mm5.length>1){
                            var mm6=(''+mm5[1]).split('href=\"')
                            if(mm6.length>1){
                                var mm7=(''+mm6[1]).split('\"')
                                var urlGit=''+mm7[0]

                                var mm8=ss0.split("</h4>")
                                var mm9=(''+mm8[0]).split('con: ')
                                var mm10=(''+mm9[0]).split('Autor: ')
                                if(mm9.length>1&&mm10.length>1){
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
                            }
                        }
                    }
                }
            }//ff
            nlm+='ListElement{nom: "spacer";des:"";dev:"";img2:"";tipo: "linux-osx-windows-android"}'
            nlm+='}\n'
            var nLm=Qt.createQmlObject(nlm, raiz, 'qmlNLM')
            lv.model = nLm
        }else{
            txtEstado.text= '<b>Error</b> Fallò la conexiòn o descarga de lista.<br>Click para Actualizar lista de Aplicaciones.'
        }
        loaded()
    }

}
