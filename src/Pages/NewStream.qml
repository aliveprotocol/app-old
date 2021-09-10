import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1
import "../Components"

Item {
    ScrollView {
        id: scrollView
        clip: true
        anchors.fill: parent
        contentHeight: newStreamRect.height

        Rectangle {
            id: newStreamRect
            anchors {
                left: parent.left
                leftMargin: 40
                right: parent.right
                rightMargin: 40
                top: parent.top
                topMargin: 0
            }
            color: "#36393f"
            // implicitHeight: 700

            Text {
                id: titleLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Title:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            AliveTextField {
                id: titleField
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: titleLbl.bottom
                anchors.topMargin: 10
                height: 25
            }

            Text {
                id: descriptionLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Description:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: titleField.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            AliveScrollableTextArea {
                id: descriptionItm
                height: 100
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: descriptionLbl.bottom
                anchors.topMargin: 10
            }

            Text {
                id: tagsLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Tags:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: descriptionItm.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            AliveTextField {
                id: tagsField
                height: 25
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: tagsLbl.bottom
                anchors.topMargin: 10
                placeholderText: qsTr("Up to 7, separated by space")
            }

            Text {
                id: selectThumbnailLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Upload a thumbnail:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: tagsField.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            AliveTextField {
                id: thumbnailDirField
                height: 25
                anchors.right: parent.right
                anchors.rightMargin: 85
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: selectThumbnailLbl.bottom
                anchors.topMargin: 10
            }

            MediumButton {
                id: thumbnailDirSelectBtn
                anchors.top: selectThumbnailLbl.bottom
                anchors.topMargin: 7.5
                btnLabel: "Browse"
                anchors.left: thumbnailDirField.right
                anchors.leftMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 0
                btnMouseArea.onClicked: fileDialog.open()
            }

            /*
            Text {
                id: dtcVwLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Avalon vote weight: 1%")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: thumbnailDirField.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            Slider {
                id: dtcVwSlider
                height: 40
                from: 1
                to: 100
                stepSize: 1
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: dtcVwLbl.bottom
                anchors.topMargin: 10
                value: 1
                snapMode: Slider.SnapOnRelease
                background: Rectangle {
                    x: dtcVwSlider.leftPadding
                    y: dtcVwSlider.topPadding + dtcVwSlider.availableHeight / 2 - height / 2
                    implicitWidth: parent.width
                    implicitHeight: 4
                    width: dtcVwSlider.availableWidth
                    height: implicitHeight
                    radius: 2
                    color: "#bdbebf"

                    Rectangle {
                        width: dtcVwSlider.visualPosition * parent.width
                        height: parent.height
                        color: "#ff0000"
                        radius: 2
                    }
                }
                onMoved: dtcVwLbl.text = "Avalon vote weight: " + dtcVwSlider.value + "%"
            }

            Text {
                id: dtcBurnLbl
                height: 22
                color: "#ffffff"
                text: qsTr("Promote with DTC burn:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: dtcVwSlider.bottom
                anchors.topMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            AliveTextField {
                id: dtcBurnField
                height: 25
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: dtcBurnLbl.bottom
                anchors.topMargin: 10
                validator: RegularExpressionValidator { regularExpression: /\d+(\.\d{1,2})?/ }
            }
            */
        }
    }


    FileDialog {
        id: fileDialog
        title: "Upload a thumbnail"
        // folder: shortcuts.home
        nameFilters: ["Image files (*.jpg *.png)"]
        onAccepted: {
            let selectedFSize = getFilesize.getFSize(fileDialog.currentFile)
            if (selectedFSize > 0 && selectedFSize <= 4194304) // 4 MB limit
                thumbnailDirField.text = fileDialog.currentFile
            else
                toast.show("Thumbnail file size must be under 4 MB",3000,3)
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:1280;width:640}
}
##^##*/
