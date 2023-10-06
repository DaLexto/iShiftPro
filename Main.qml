import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import DaLexto
import DaLexto.Utils
import DaLexto.Controls

AppWindow {
    id:mainWindow
    width: 1080; height: 768
    minimumHeight: 480; minimumWidth: 640
    titleBarSize: 40
    color: Theme.window
//---
    Rectangle{
        id: titleBar
        width: parent.width; height: mainWindow.titleBarSize
        color: Theme.base

        DaButton{
            id:quitButton
            anchors.right: parent.right
            width: height; height: parent.height
            radius: 0

            flat: true

            icon.source: Provide.icon("navigation", "close")
            onClicked: mainWindow.quitApplication()
        }

        DaButton{
            id:maximizeButton
            anchors.right: quitButton.left
            width: height; height: parent.height
            radius: 0

            flat: true

            icon.source: Provide.icon("action", "maximize2")
            icon.width: 20
            icon.height: 20
            onClicked: mainWindow.maximizeWindow()
        }

        DaButton{
            id:minimizeButton
            anchors.right: maximizeButton.left
            width: height; height: parent.height
            radius: 0

            flat: true

            icon.source: Provide.icon("action", "minimize")
            onClicked: mainWindow.minimizeWindow()
        }

        DaButton{
            id:tipsButton
            anchors.right: minimizeButton.left
            width: height; height: parent.height
            radius: 0

            flat: true

            icon.source: Provide.icon("action", "lightbulb")
            onClicked: console.log("Tips don't do anything yet!")
        }

        DaButton{
            id:settingButton
            anchors.right: tipsButton.left
            width: height; height: parent.height
            radius: 0

            flat: true

            icon.source: Provide.icon("action", "settings")
            onClicked: console.log("Settings don't do anything yet!")
        }
    }
//---
    Rectangle{
        id: menuBar
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        width: parent.width; height: 40
        color: "transparent"/*
        border.color: "black"  //debgging only
        border.width: 2*/

        //...
        DaButton{
            id: menuButton
            anchors.left: parent.left
            anchors.leftMargin: 12
            width: height; height: parent.height
            radius: 3

            flat: true

            icon.source: Provide.icon("navigation","menu")
        }
        //...
        ButtonGroup{
            id: menuBarGroup
            buttons: menuButtons.children
            checkedButton: homeButton
            onClicked: function(button){button.checked = true}
        }
        Item{
            id:menuButtons
            anchors.left: menuButton.right
            //..
            DaButton{
                id:homeButton
                anchors.left: parent.left
                width: 65; height: 28
                radius: 3

                buttonColor: "transparent"

                text: qsTr("Home")
                font.pixelSize: 16
                font.bold: homeButton.hovered || homeButton.checked

                onClicked: console.log(text + " - button does nothing yet.")
            }
            DaButton{
                id:viewButton
                anchors.left: homeButton.right
                width: 65; height: 28
                radius: 3

                buttonColor: "transparent"

                text: qsTr("View")
                font.pixelSize: 16
                font.bold: viewButton.hovered || viewButton.checked

                onClicked: console.log(text + " - button does nothing yet.")
            }

            DaButton{
                id:helpButton
                anchors.left: viewButton.right
                width: 65; height: 28
                radius: 3

                buttonColor: "transparent"

                text: qsTr("Help")
                font.pixelSize: 16
                font.bold: helpButton.hovered || helpButton.checked

                onClicked: console.log(text + " - button does nothing yet.")
            }
            //..
        }
        //...
        DaSwitch{
            id: themeSwitch
            anchors.right: parent.right
            text: qsTr("Light")
            onCheckedChanged:{
                Theme.switchTheme(themeSwitch.checked ? "dark" : "light")
                text = themeSwitch.checked ? qsTr("Dark") : qsTr("Light")
            }
        }

    }
//---
    Rectangle{
        id: controlBar
        anchors.top: menuBar.bottom
        anchors.horizontalCenter: menuBar.horizontalCenter
        width: parent.width - 20; height: 45
        radius: 5

        color: Theme.base
    }

/////////////////////////////////////////////////////////
    property Splash splash: Splash {
        onTimeout: mainWindow.show()
    }
    component Splash: Window{
        id: splashScreen
        flags: Qt.SplashScreen
        color: "transparent"
        modality: Qt.ApplicationModal // in case another application window is showing
        title: "Splash Window" // for the taskbar/dock, task switcher etc.
        visible: true

        x: (Screen.width - splashImage.width) / 2
        y: (Screen.height - splashImage.height) / 2
        width: splashImage.width
        height: splashImage.height
        property int timeoutInterval: 2000
        signal timeout
        Image {
            id: splashImage
            source: Provide.icon("logos","splash")
        }
        TapHandler {
            onTapped: splashScreen.timeout()
        }
        Timer {
            interval: splashScreen.timeoutInterval; running: true; repeat: false
            onTriggered: {
                splashScreen.visible = false
                splashScreen.timeout()
            }
        }
    }

}



