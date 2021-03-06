QT += quick
QT += network

CONFIG += c++17
CONFIG += resources_big

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

PRECOMPILED_HEADER = include/PreCompile.h

INCLUDEPATH += \
		include/				\
		../protobuf_headers/	\
		../protocol/			\

win32: {
	DEFINES += PROTOBUF_USE_DLLS
	LIBS += \
		-L$$PWD/../lib/ -llibprotobuf	\
		-L$$PWD/../lib/ -llibprotobufd	\
}
android: {
	LIBS += $$PWD/../lib/libprotobuf.a
}
# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        ../protocol/UserProtocol.pb.cc \
		../protocol/BattleProtocol.pb.cc \
        src/ClientBackend/NetworkHelper/NetworkHelper.cpp \
        src/ClientBackend/ClientBackend.cpp \
        src/PreCompile.cpp \
        src/main.cpp

RESOURCES += \
	qml.qrc \
	resource.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


win32-msvc* {
    QMAKE_CXXFLAGS *=  /wd"4244"
    contains (QMAKE_CXXFLAGS_WARN_ON, -w34244) : QMAKE_CXXFLAGS_WARN_ON -= -w34244
    QMAKE_CXXFLAGS *=  /wd"4267"
    contains (QMAKE_CXXFLAGS_WARN_ON, -w34267) : QMAKE_CXXFLAGS_WARN_ON -= -w34267
    QMAKE_CXXFLAGS *=  /wd"4100"
    contains (QMAKE_CXXFLAGS_WARN_ON, -w34100) : QMAKE_CXXFLAGS_WARN_ON -= -w34100
    QMAKE_CXXFLAGS *=  /wd"4251"
    contains (QMAKE_CXXFLAGS_WARN_ON, -w34251) : QMAKE_CXXFLAGS_WARN_ON -= -w34251
}

HEADERS += \
	../protocol/MessageTypeGlobal.h \
	include/PreCompile.h \
	src/ClientBackend/NetworkHelper/NetworkHelper.h \
	src/ClientBackend/ClientBackend.h
