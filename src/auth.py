from PySide2.QtCore import QObject, Slot, Signal

import requests
import base58
import secp256k1

class DTCLoginBridge(QObject):
    startSignal = Signal(str, str)
    loginResult = Signal(int, arguments=['result'])

    def __init__(self, obj, parent=None):
        super().__init__(parent)
        self.m_obj = obj
        self.m_obj.loginResult.connect(self.loginResult)
        self.startSignal.connect(self.m_obj.auth)

class DTCLogin(QObject):
    loginResult = Signal(int)

    @Slot(str, str)
    def auth(self, username, private_key):
        # TODO: Move API to settings page accessible from anywhere in app
        # Should this be in a dedicated Avalon Python library?
        avalon_account = requests.get('https://avalon.oneloved.tube/account/' + username)
        if avalon_account.status_code != 200:
            self.loginResult.emit(2)
        try:
            public_key = base58.b58encode(secp256k1.PrivateKey(base58.b58decode(private_key)).pubkey.serialize()).decode('UTF-8')
        except:
            self.loginResult.emit(3)
        if avalon_account.json()['pub'] != public_key:
            valid_key = False
            for i in range(0,len(avalon_account.json()['keys'])):
                # TODO: Update with the correct op # on livestreaming HF
                if avalon_account.json()['keys'][i]['pub'] == public_key and all(x in avalon_account.json()['keys'][i]['types'] for x in [19, 20]):
                    # avalon_keyid = avalon_account.json()['keys'][i]['id']
                    valid_key = True
                    break
            if valid_key == False:
                self.loginResult.emit(3)
            else:
                self.loginResult.emit(0)
        else:
            self.loginResult.emit(1)
