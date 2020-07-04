# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2 import QtCore

import auth

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Worker thread
    workerThread = QtCore.QThread()
    workerThread.start()

    # Signal slots
    dtcLogin = auth.DTCLogin()
    dtcLogin.moveToThread(workerThread)
    dtcLoginBridge = auth.DTCLoginBridge(dtcLogin)
    engine.rootContext().setContextProperty("dtcLoginBridge", dtcLoginBridge)

    # Load QML files
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
