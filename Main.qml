import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import DaLexto
import DaLexto.Utils
import DaLexto.Controls

AppWindow {
    id:mainWindow
    width: 1080
    height: 768
    minimumHeight: 480
    minimumWidth: 640
    titleBarSize: 40
    //color: "#1f1f1f"
    color: Theme.window

    Rectangle{
        id: titleBar
        width: parent.width
        height: mainWindow.titleBarSize
        color: Theme.base

        DaButton{
            id:quitButton
            anchors.right: parent.right
            height: parent.height
            width: height
            radius: 0
            buttonHover: Theme.hoverDanger
            icon.source: Provide.icon("navigation", "close")
            onClicked: mainWindow.quitApplication()
        }
        DaButton{
            id:maximizeButton
            anchors.right: quitButton.left
            height: parent.height
            width: height
            radius: 0
            icon.source: Provide.icon("action", "maximize2")
            icon.width: 20
            icon.height: 20
            onClicked: mainWindow.maximizeWindow()
        }
        DaButton{
            id:minimizeButton
            anchors.right: maximizeButton.left
            height: parent.height
            width: height
            radius: 0
            icon.source: Provide.icon("action", "minimize")
            onClicked: mainWindow.minimizeWindow()
        }
        DaButton{
            id:tipsButton
            anchors.right: minimizeButton.left
            height: parent.height
            width: height
            radius: 0
            buttonHover: Theme.hoverInfo
            icon.source: Provide.icon("action", "lightbulb")
            onClicked: console.log("Tips don't do anything yet!")
        }
        DaButton{
            id:settingButton
            anchors.right: tipsButton.left
            height: parent.height
            width: height
            radius: 0
            buttonHover: Theme.hoverInfo
            icon.source: Provide.icon("action", "settings")
            onClicked: console.log("Settings don't do anything yet!")
        }
    }

    Rectangle{
        id: menuBar
        anchors.top: titleBar.bottom
        width: parent.width
        height: 50
        color: "transparent"
        DaButton{
            id: menuButton

        }
    }

    DaSwitch{
        id: themeSwitch
        text: qsTr("Light")
        onCheckedChanged:{
            Theme.switchTheme(themeSwitch.checked ? "dark" : "light")
            text = themeSwitch.checked ? qsTr("Dark") : qsTr("Light")
        }

    }


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



