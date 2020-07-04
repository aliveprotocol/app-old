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

    // Setup
    StackView {
        id: setupStack
        initialItem: welcomePage
        anchors.fill: parent
    }

    Welcome {
        id: welcomePage
        getStartedMouseArea.onClicked: {
            // Get started button mouseArea.onClicked()
            setupStack.push(dtcLoginPage)
        }
    }

    DTCLogin {
        id: dtcLoginPage
        visible: false
        proceedLoginBtnMouseArea.onClicked: {
            let dtclogin = dtcLogin.auth(dtcLoginPage.dtcUsername, dtcLoginPage.dtcKey)
            switch (dtclogin) {
            case 0:
                toast.show("Logged in with custom key successfully",3000,1)
                setupStack.push(createPinPage)
                break
            case 1:
                toast.show("Logged in with master key successfully",3000,1)
                setupStack.push(createPinPage)
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
        }
    }

    // Toasts
    ToastManager { id: toast }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
