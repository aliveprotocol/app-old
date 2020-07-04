import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "./Pages"

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
            if (dtclogin)
                console.log("Correct key")
            else
                console.log("Wrong key")
        }
    }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
