import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import "./Components"

Item {
    property var toast
    property int tabIndex: 0

    width: 900
    height: 600

    Rectangle {
        x: 0
        y: 0
        width: 200
        height: 600
        color: "#222222"

        ColumnMenuButton {
            id: dashboardMenuBtn
            btnLabel: qsTr("Dashboard")
            anchors.top: parent.top
            anchors.topMargin: 50
            selected: tabIndex == 0
            btnMouseArea.onClicked: tabIndex = 0
        }

        ColumnMenuButton {
            id: createStreamMenuBtn
            btnLabel: qsTr("Create Stream")
            anchors.top: dashboardMenuBtn.bottom
            selected: tabIndex == 1
            btnMouseArea.onClicked: tabIndex = 1
        }
        ColumnMenuButton {
            id: goLiveMenuBtn
            btnLabel: qsTr("Go Live")
            anchors.top: createStreamMenuBtn.bottom
            selected: tabIndex == 2
            btnMouseArea.onClicked: tabIndex = 2
        }

        ColumnMenuButton {
            id: recentStreamsMenuBtn
            btnLabel: qsTr("Recent Streams")
            anchors.top: goLiveMenuBtn.bottom
            selected: tabIndex == 3
            btnMouseArea.onClicked: tabIndex = 3
        }
        ColumnMenuButton {
            id: settingsMenuBtn
            btnLabel: qsTr("Settings")
            anchors.bottom: accountMenuBtn.top
            selected: tabIndex == 4
            btnMouseArea.onClicked: tabIndex = 4
        }

        ColumnMenuButton {
            id: accountMenuBtn
            btnLabel: qsTr("Account")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            selected: tabIndex == 5
            btnMouseArea.onClicked: tabIndex = 5
        }
    }

    StackLayout {
        id: stackLayout
        x: 200
        y: 0
        width: 700
        height: 600
        currentIndex: -1
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
