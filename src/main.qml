import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "./Pages"
import "./Components"

Window {
    title: qsTr("Alive")
    width: 900
    height: 600
    minimumWidth: 900
    minimumHeight: 600
    maximumWidth: 900
    maximumHeight: 600
    color: "#36393f"
    visible: true

    // SETUP
    StackView {
        id: setupStack
        initialItem: setupView.welcomeView
        anchors.fill: parent
    }

    Setup {
        id: setupView
        toast: toastManager
        stack: setupStack
    }

    // MAIN UI


    // TOASTS
    ToastManager { id: toastManager }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
