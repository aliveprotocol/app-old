# This Python file uses the following encoding: utf-8
import sys
import os
from PySide6 import QtCore, QtGui, QtQml
from Helpers import fileHelper
import dtc
import hive
import credentials
import settings

def handle_exit():
    workerThread.terminate()

if __name__ == "__main__":
    app = QtGui.QGuiApplication(sys.argv)
    app.setWindowIcon(QtGui.QIcon('alivelogo.png'))
    engine = QtQml.QQmlApplicationEngine()

    # Worker thread
    workerThread = QtCore.QThread()
    workerThread.start()

    # Signal slots
    dtcLogin = dtc.DTCLogin()
    dtcLogin.moveToThread(workerThread)
    dtcLoginBridge = dtc.DTCLoginBridge(dtcLogin)
    engine.rootContext().setContextProperty("dtcLoginBridge", dtcLoginBridge)

    dtcGetAcc = dtc.GetAccount()
    dtcGetAcc.moveToThread(workerThread)
    dtcGetAccBridge = dtc.GetAccountBridge(dtcGetAcc)
    engine.rootContext().setContextProperty("dtcGetAccBridge", dtcGetAccBridge)

    hiveLogin = hive.HiveLogin()
    hiveLogin.moveToThread(workerThread)
    hiveLoginBridge = hive.HiveLoginBridge(hiveLogin)
    engine.rootContext().setContextProperty("hiveLoginBridge", hiveLoginBridge)

    hiveAcc = hive.HiveAccount()
    hiveAcc.moveToThread(workerThread)
    hivePowerBridge = hive.HivePowerBridge(hiveAcc)
    hiveGetRcBridge = hive.HiveRcBridge(hiveAcc)
    hiveCommunitySubBridge = hive.HiveCommunitySubBridge(hiveAcc)
    engine.rootContext().setContextProperty("hivePowerBridge", hivePowerBridge)
    engine.rootContext().setContextProperty("hiveGetRcBridge", hiveGetRcBridge)
    engine.rootContext().setContextProperty("hiveCommunitySubBridge", hiveCommunitySubBridge)

    getFilesize = fileHelper.GetFilesize()
    engine.rootContext().setContextProperty("getFilesize", getFilesize)

    creds = credentials.CredentialsInstance()
    engine.rootContext().setContextProperty("credInstance", creds)

    userSettings = settings.UserSettingsInstance()
    engine.rootContext().setContextProperty("userSettingsInstance", userSettings)

    # Load QML files
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    # Handle app termination
    app.lastWindowClosed.connect(handle_exit)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
