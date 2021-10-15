import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Components"

Item {
    ScrollView {
        id: scrollView
        clip: true
        anchors.fill: parent
        contentHeight: accSeetingsRect.height

        Rectangle {
            id: accSeetingsRect
            anchors {
                left: parent.left
                leftMargin: 40
                right: parent.right
                rightMargin: 40
                top: parent.top
                topMargin: 0
            }
            color: "#36393f"

            Text {
                id: hiveUsernameLbl
                height: 22
                color: '#ffffff'
                text: qsTr("Hive Username: %1").arg(credInstance ? credInstance.get_username_by_network('hive') : '')
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            MediumButton {
                id: hiveLogoutBtn
                anchors.left: hiveUsernameLbl.right
                anchors.leftMargin: 10
                anchors.verticalCenter: hiveUsernameLbl.verticalCenter
                btnLabel: qsTr("Logout")
                btnMouseArea.onClicked: {
                    credInstance.remove_credential('hive')
                    credInstance.write_credentials()
                    logoutCallback()
                    toast.show(qsTr("Logged out of Hive account successfully"),3000,1)
                }
            }
        }
    }
}
