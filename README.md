# Alive

A Qt Quick desktop app for decentralized live streaming on Hive and Avalon.

## Required Packages

#### Linux
```
sudo apt-get install -y python3 python3-pip build-essential automake pkg-config libtool libffi-dev libgmp-dev libopengl0 libsecp256k1-dev
```

#### macOS
```
brew install python3 automake pkg-config libtool libffi gmp
git clone https://github.com/bitcoin-core/secp256k1
cd secp256k1
./autogen.sh
./configure
make install
```

#### Windows

TBD

## Build

1. Install required dependencies.

```
pip3 install -r requirements.txt
```

2. Run the main script to start the app.

```
python3 src/main.py
```

## Development

Qt Creator is the recommeneded IDE when working with QML files for UI logic, which can be downloaded [here](https://www.qt.io/download-open-source). Additionally, you may prefer to use your preferred code editor for other files.

#### Troubleshooting

Qt Creator not launching on Ubuntu: https://askubuntu.com/questions/1271976/could-not-load-the-qt-platform-plugin-xcb-in-even-though-it-was-found