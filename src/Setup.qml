import QtQuick 2.15
import QtQuick.Window 2.14
import QtQuick.Controls 2.15
import "./Pages"
import "./Components"

Item {
    property var toast
    property var stack
    property var welcomeView: welcomePage
    property var callback

    anchors.fill: parent

    Welcome {
        id: welcomePage
        getStartedMouseArea.onClicked: {
            // Get started button mouseArea.onClicked()
            stack.push(networkSelectAvalon)
        }
    }

    NetworkSelect {
        id: networkSelectAvalon
        visible: false
        networkSelectAvalonMouseArea.onClicked: stack.push(dtcLoginPage)
        networkSelectHiveMouseArea.onClicked: stack.push(hiveLoginPage)
        networkSelectBackMouseArea.onClicked: stack.pop()
    }

    DTCLogin {
        id: dtcLoginPage
        visible: false
        backBtnMouseArea.onClicked: stack.pop()
        proceedLoginBtnMouseArea.onClicked: dtcLoginBridge.startSignal(dtcLoginPage.dtcUsername, dtcLoginPage.dtcKey)

        Connections {
            target: dtcLoginBridge
            function onLoginResult(result) {
                switch (result) {
                case 0:
                    toast.show("Logged in with custom key successfully",3000,1)
                    credInstance.add_credential('dtc',dtcLoginPage.dtcUsername, dtcLoginPage.dtcKey)
                    stack.push(createPinPage)
                    break
                case 1:
                    toast.show("Logged in with master key successfully",3000,1)
                    credInstance.add_credential('dtc',dtcLoginPage.dtcUsername, dtcLoginPage.dtcKey)
                    stack.push(createPinPage)
                    break
                case 2:
                    toast.show("Invalid username",3000,3)
                    break
                case 3:
                    toast.show("Invalid key",3000,3)
                    break
                default:
                    toast.show("Unknown error",3000,3)
                }
            }
        }
    }

    HiveLogin {
        id: hiveLoginPage
        visible: false
        backBtnMouseArea.onClicked: stack.pop()
    }

    CreatePin {
        id: createPinPage
        visible: false
        confirmPinBtnMouseArea.onClicked: {
            if (createPinPage.newPin.length < 4)
                return toast.show("PIN must be at least 4 digits long",3000,3)
            else if (createPinPage.newPin !== createPinPage.confirmPin)
                return toast.show("New PIN and Confirm PIN does not match",3000,3)
            toast.show("PIN created successfully",3000,1)
            // TODO: Store auth details
            createPinPage.visible = false
            callback()
        }
    }
}
