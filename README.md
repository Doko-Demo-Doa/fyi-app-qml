# FYI sample app (QML)

Simple video app. Used for assessment at FYI. Re-implemented in [QML](https://doc.qt.io/qt-5/qtqml-index.html).

# Requirements

Same with previous submission, located [here](https://github.com/Doko-Demo-Doa/fyi-app)

- Qt 5 or 6. Should be downloaded using [Qt maintenance tool](https://www.qt.io/download)
- Proper build tools installed on specific systems
  - **Windows**: [Visual Studio](https://visualstudio.microsoft.com/) (**NOT** Visual Studio Code, Community Edition is more than enough, latest version is fine).
  - **Mac OS**: XCode. Install from AppStore. After installing, run it once to install mandatory components.
  - **Linux**: May vary. On Debian/Ubuntu, it should be `build-essential` package.
- A codec (_MUST_ be installed): Because Qt media backend does not support some video formats (VP9 or H265, which are popular these days). We need to install additional codec (even for end-users). Recommendation is [K-Lite Codec Pack (Basic)](https://codecguide.com/download_k-lite_codec_pack_basic.htm)

# Building

Following guide is for Windows. Mac OS and Linux may differ but not much. The main difference is the build tool we choose (I prefer MSVC over MinGW because Visual Studio is not that bad anymore).

## Install Visual Studio with necessary components

For this app, we choose "Desktop Development with C++" package. It's pretty big (about 6GB) but we need it for Qt to compile and it's much easier than fighting with MinGW command lines. So let's go with it.

![Visual Studio Installer](/images/vs-package.png)

## Get the code

```sh
git clone https://github.com/Doko-Demo-Doa/fyi-app.git
```

## Make sure Qt is in the PATH

This is the major difference from previous submission. Because there is no easy way to include `qmltypes` in Qt 5 (which I chose, for maximum compatibility), `qmake` is the choice here.

After Qt installation (using Online Installer or Qt Maintenance Tool). It will be (typically) installed in `C:\Qt` on Windows or `$HOME/Qt` on MacOS. Also after that, install a recent version of Qt 5 or 6 (both should work with this simple app).

![Qt Tool](/images/qt-tool.png)

Note: Be sure to add the `bin` folder. It should be something like this (`C:\Qt\<qt_version>\<compiler_version>\bin`):

e.g:

```
C:\Qt\5.15.2\msvc2019_64\bin
```

You may need to restart any Powershell / Command line / Terminal currently opening to take effect.

## Create the build folder

Note: This also works with PowerShell on Windows

```bash
mkdir build
```

_Reason_: This is just a convention. By default CMake generates a lot of files/folders into working directory.
They should be in a build folder instead and also should be ignored by version control (typically Git).

## Configure the project using QtCreator

In previous submission, cmake is the choice because it goes well with "command-and-code" way. There are various things that Qt Creator and qmake take care of nicely in this case, so let's go for that.

Click on File > Open File or Project...

![QtCreator](/images/qtcreator.png)

Select the `.pro` file:

![QtCreator](/images/select-file.png)

Wait for several seconds for Qt Creator to configure the project, then run the app in debug mode by clicking the green button like so:

![QtCreator](/images/run-app.png)

# Known issues

- Codec should be bundled or embedded in the app (through dynamic or static linking).
- The slider is somewhat off in the layout.