import QtQuick 2.15

/**
 * adapted from StackOverflow:
 * http://stackoverflow.com/questions/26879266/make-toast-in-android-by-qml
 */

/**
  * @brief An Android-like timed message text in a box that self-destroys when finished if desired
  */
Rectangle {

    /**
      * Public
      */

    /**
      * @brief Shows this Toast
      *
      * @param {string} text Text to show
      * @param {real} duration Duration to show in milliseconds, defaults to 3000
      * @param {real} toastType Type of toast to show (0: info, 1: success, 2: warning, 3: error)
      */
    function show(text, duration = 3000, toastType = 0) {
        message.text = text;
        if (typeof duration !== "undefined") // checks if parameter was passed
            time = Math.max(duration, 2 * fadeTime);
        else
            time = defaultTime;

        if (typeof toastType === "number" && toastType >= 0 && toastType <= 3)
            type = toastType
        else
            type = defaultType

        animation.start();
    }

    property bool selfDestroying: false  // whether this Toast will self-destroy when it is finished

    /**
      * Private
      */

    id: root

    readonly property real defaultTime: 3000
    property real time: defaultTime
    readonly property real fadeTime: 300

    readonly property real defaultType: 0
    property real type: defaultType

    property real margin: 10

    anchors {
        left: parent.left
        right: parent.right
        margins: margin
    }

    height: message.height + margin
    radius: margin

    opacity: 0
    color: {
        switch (type) {
        case 0:
            return "#00aeff"
        case 1:
            return "#33f707"
        case 2:
            return "#fff000"
        case 3:
            return "#f9553b"
        default:
            return "#fff000"
        }
    }

    Text {
        id: message
        color: {
            if (type == 1 || type == 2)
                return "block"
            else
                return "white"
        }
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: margin / 2
        }
    }

    SequentialAnimation on opacity {
        id: animation
        running: false


        NumberAnimation {
            to: .9
            duration: fadeTime
        }

        PauseAnimation {
            duration: time - 2 * fadeTime
        }

        NumberAnimation {
            to: 0
            duration: fadeTime
        }

        onRunningChanged: {
            if (!running && selfDestroying) {
                root.destroy();
            }
        }
    }
}
