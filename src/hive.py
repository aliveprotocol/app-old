from PySide6 import QtCore
from beem import Hive
from beemgraphenebase import account
import requests

class HiveLoginBridge(QtCore.QObject):
    startSignal = QtCore.Signal(str, str)
    hiveLoginResult = QtCore.Signal(int, arguments=['result'])

    def __init__(self, obj, parent=None):
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.hiveLoginResult.connect(self.hiveLoginResult)
        self.startSignal.connect(self.m_obj.auth)

class HiveLogin(QtCore.QObject):
    hiveLoginResult = QtCore.Signal(int)

    @QtCore.Slot(str, str)
    def auth(self, username, private_key):
        try:
            hive_pubkey = account.PrivateKey(wif=private_key,prefix='STM').get_public_key()
        except:
            return self.hiveLoginResult.emit(3)
        hive_accreq = {
            'jsonrpc': '2.0',
            'id': 1,
            'method': 'condenser_api.get_accounts',
            'params': [[username]]
        }
        # support posting authorities from other accounts?
        hive_accresp = requests.post("https://techcoderx.com",json=hive_accreq)
        if hive_accresp.status_code != 200:
            return self.hiveLoginResult.emit(1)
        hive_accresult = hive_accresp.json()['result']
        if len(hive_accresult) == 0:
            return self.hiveLoginResult.emit(2)
        hive_acckeys = hive_accresult[0]['posting']
        for i in range(len(hive_acckeys['key_auths'])):
            if hive_acckeys['key_auths'][i][0] == str(hive_pubkey):
                return self.hiveLoginResult.emit(0)
        return self.hiveLoginResult.emit(3)