from PySide6 import QtCore
from Daemon import alivedb
from Daemon.alivedb_integrity import version as alivedb_version
from settings import UserSettingsInstance

class ADBInstaller(QtCore.QObject):
    startSignal = QtCore.Signal()
    adbInstallResult = QtCore.Signal(bool, arguments=['result'])

    def __init__(self, obj, parent=None) -> None:
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.adbInstallResult.connect(self.adbInstallResult)
        self.startSignal.connect(self.m_obj.install)

class ADBInstallStatusBridge(QtCore.QObject):
    startSignal = QtCore.Signal()
    adbInstallStatusResult = QtCore.Signal(int, str, arguments=['result','version'])

    def __init__(self, obj, parent=None):
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.adbInstallStatusResult.connect(self.adbInstallStatusResult)
        self.startSignal.connect(self.m_obj.getStatus)

class ADBInstallation(QtCore.QObject):
    adbInstallResult = QtCore.Signal(bool)
    adbInstallStatusResult = QtCore.Signal(int, str)

    def __init__(self, settingsInstance: UserSettingsInstance) -> None:
        super().__init__()
        self.settingsInstance = settingsInstance

    @QtCore.Slot()
    def install(self):
        try:
            alivedb.alivedb_install()
            self.adbInstallResult.emit(True)
        except Exception:
            self.adbInstallResult.emit(False)

    @QtCore.Slot()
    def getStatus(self):
        return self.adbInstallStatusResult.emit(alivedb.alivedb_installation_check(dev_mode=self.settingsInstance.get('devMode')),alivedb_version)