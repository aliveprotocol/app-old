from PySide2.QtCore import QObject, Slot

import requests
import base58
import secp256k1

class DTCLogin(QObject):
    @Slot(str, str, result=bool)
    def auth(self, username, private_key):
        # TODO: Move API to settings page accessible from anywhere in app
        # Should this be in a dedicated Avalon Python library?
        avalon_account = requests.get('https://avalon.oneloved.tube/account/' + username)
        if avalon_account.status_code != 200:
            print('Avalon account does not exist')
            return False
        try:
            public_key = base58.b58encode(secp256k1.PrivateKey(base58.b58decode(private_key)).pubkey.serialize()).decode('UTF-8')
        except:
            print('Invalid key')
            return False
        if avalon_account.json()['pub'] != public_key:
            valid_key = False
            for i in range(0,len(avalon_account.json()['keys'])):
                # TODO: Update with the correct op # on livestreaming HF
                if avalon_account.json()['keys'][i]['pub'] == public_key and all(x in avalon_account.json()['keys'][i]['types'] for x in [19, 20]):
                    # avalon_keyid = avalon_account.json()['keys'][i]['id']
                    valid_key = True
                    break
            if valid_key == False:
                print('Invalid Avalon key')
                return False
            else:
                print('Logged in with custom key')
        else:
            print('Logged in with master key')
        return True
