import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "./Components"

Window {
    title: qsTr("Alive")
    width: 900
    height: 600
    minimumWidth: 900
    minimumHeight: 600
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
        callback: switchToMainView
    }

    // MAIN UI
    MainUI {
        id: mainView
        visible: false
        toast: toastManager
        logoutCallback: loggedOutView
    }

    // TOASTS
    ToastManager { id: toastManager }

    // SWITCH TO MAIN VIEW
    function switchToMainView() {
        setupView.visible = false
        mainView.visible = true
    }

    // LOGOUT
    function loggedOutView() {
        mainView.visible = false
        setupView.visible = true
        setupStack.visible = true
        setupStack.pop(null)
        setupView.welcomeView.visible = true
    }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
