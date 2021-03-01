from PySide6 import QtCore

import requests
import base58
import secp256k1

class DTCLoginBridge(QtCore.QObject):
    startSignal = QtCore.Signal(str, str)
    avalonLoginResult = QtCore.Signal(int, arguments=['result'])

    def __init__(self, obj, parent=None):
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.avalonLoginResult.connect(self.avalonLoginResult)
        self.startSignal.connect(self.m_obj.auth)

class DTCLogin(QtCore.QObject):
    avalonLoginResult = QtCore.Signal(int)

    @QtCore.Slot(str, str)
    def auth(self, username, private_key):
        # TODO: Move API to settings page accessible from anywhere in app
        avalon_account = requests.get('http://192.168.0.186:3003/account/' + username)
        if avalon_account.status_code != 200:
            self.avalonLoginResult.emit(2)
        try:
            public_key = base58.b58encode(secp256k1.PrivateKey(base58.b58decode(private_key)).pubkey.serialize()).decode('UTF-8')
        except:
            self.avalonLoginResult.emit(3)
        if avalon_account.json()['pub'] != public_key:
            valid_key = False
            for i in range(0,len(avalon_account.json()['keys'])):
                # TODO: Update with the correct op # on livestreaming HF
                if avalon_account.json()['keys'][i]['pub'] == public_key and all(x in avalon_account.json()['keys'][i]['types'] for x in [19, 20]):
                    # avalon_keyid = avalon_account.json()['keys'][i]['id']
                    valid_key = True
                    break
            if valid_key == False:
                self.avalonLoginResult.emit(3)
            else:
                self.avalonLoginResult.emit(0)
        else:
            self.avalonLoginResult.emit(1)

class GetAccountBridge(QtCore.QObject):
    startSignal = QtCore.Signal(str)
    avalonAccResult = QtCore.Signal(str, arguments=['result'])

    def __init__(self, obj, parent=None):
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.avalonAccResult.connect(self.avalonAccResult)
        self.startSignal.connect(self.m_obj.getAccount)

class GetAccount(QtCore.QObject):
    avalonAccResult = QtCore.Signal(str)

    @QtCore.Slot(str)
    def getAccount(self,username):
        account = requests.get('http://192.168.0.186:3003/account/' + username)
        if account.status_code != 200:
            self.avalonAccResult.emit("Error")
        else:
            self.avalonAccResult.emit(account.text)