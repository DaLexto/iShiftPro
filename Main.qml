import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import DaLexto.Utils
import DaLexto.Controls

AppWindow {
    id:mainWindow
    width: 1080
    height: 768
    minimumHeight: 480
    minimumWidth: 640
    color: "#1f1f1f"

    DaButton{
        id:test
        anchors.centerIn: parent
        width: 80
        height: 35
        text: qsTr("Buton")

        onClicked: mainWindow.quitApplication()
    }
    Item{

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
            source: "qrc:/DaLexto/assets/LOGO.png"
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



