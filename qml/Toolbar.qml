import QtQuick 2.15
import QtQuick.Layouts 1.0
import QtQuick.Controls
//import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import "dataexport.js" as CSVExport
import "sesssave.js" as StateSave

ToolbarStyle {
  ButtonGroup {
    id: timeGroup
  }

  property alias repeatedSweep: repeatedSweepItem.checked
  property alias plotsVisible: plotsVisibleItem.checked
  property alias contentVisible: contentVisibleItem.checked
  property alias deviceMngrVisible: deviceMngrVisibleItem.checked
  property alias colorDialog: sessColorDialog
  property alias acqusitionDialog: sessAcqSettDialog

  AcquisitionSettingsDialog {
    id: sessAcqSettDialog
  }

  FileDialog {
    id: dataDialog
    fileMode: FileDialog.SaveFile  // Replaces selectExisting: false
    title: "Please enter a location to save your data."
    nameFilters: [ "CSV files (*.csv)", "All files (*)" ]
    onAccepted: { CSVExport.saveData(dataDialog.selectedFile);}  // Changed from fileUrls[0]
  }
  FileDialog {
    id: sessSaveDialog
    fileMode: FileDialog.SaveFile  // Replaces selectExisting: false
    title: "Please enter a location to save your session."
    nameFilters: [ "JSON files (*.json)", "All files (*)" ]
    onAccepted: { fileio.writeByURI(sessSaveDialog.selectedFile, JSON.stringify(StateSave.saveState(), 0, 2));}
  }
  
  FileDialog {
    id: sessRestoreDialog
    fileMode: FileDialog.OpenFile
    title: "Please select a session to restore."
    nameFilters: [ "JSON files (*.json)", "All files (*)" ]
    onAccepted: { StateSave.restoreState(JSON.parse(fileio.readByURI(sessRestoreDialog.selectedFile)));}
  }

  ColorControlDialog {
    id: sessColorDialog
  }

  ToolButton {
    text: "Menu"
    Layout.fillHeight: true
    background: Rectangle {
      implicitWidth: 56
      implicitHeight: 40
      opacity: parent.pressed ? 0.3 : parent.checked ? 0.2 : 0.01
      color: 'white'
    }
    
    icon.source: 'qrc:/icons/gear.png'
    
    onClicked: contextMenu.popup()
    
    Menu {
      id: contextMenu
  
      MenuItem {
          id: repeatedSweepItem
          text: "Repeated sweep"
          checkable: true
          checked: true
      }
  
      Menu {
        title: "Sample Time"
        MenuItem { 
          ButtonGroup.group: timeGroup
          checkable: true
          checked: controller.sampleTime == 0.01 ? true : false
          onTriggered: controller.sampleTime = 0.01
          text: '10 ms' 
        }
        MenuItem { 
          ButtonGroup.group: timeGroup
          checkable: true
          checked: controller.sampleTime == 0.1 ? true : false
          onTriggered: controller.sampleTime = 0.1
          text: '100 ms' 
        }
        MenuItem { 
          ButtonGroup.group: timeGroup
          checkable: true
          checked: controller.sampleTime == 1 ? true : false
          onTriggered: controller.sampleTime = 1
          text: '1 s' 
        }
        MenuItem { 
          ButtonGroup.group: timeGroup
          checkable: true
          checked: controller.sampleTime == 10 ? true : false
          onTriggered: controller.sampleTime = 10
          text: '10 s' 
        }
      }
  
      MenuItem {
          id: dataLoggingItem
          text: "Data logging"
          checkable: true
          checked: false
          enabled: controller.sampleTime == 0.1 || controller.sampleTime == 0.01 ? false : true
          onTriggered: session.onLoggingChanged()
      }
  
      MenuItem {
        id: plotsVisibleItem
        text: "X-Y Plots"
        checkable: true
      }
  
      MenuItem {
        id: contentVisibleItem
        text: "About"
        checkable: true
      }
  
      MenuItem {
        id: deviceMngrVisibleItem
        text: "Device Manager"
        checkable: true
      }
  
      MenuSeparator{}
      MenuItem {
        id: acquisVisibleItem
        text: "Acquisition Settings"
        onTriggered: sessAcqSettDialog.open()
      }
      MenuItem {
        id: dataSaveVisibleItem
        text: "Export Data"
        onTriggered: dataDialog.open()
      }
      MenuItem {
        id: sessionSaveVisibleItem
        text: "Save Session"
        onTriggered: sessSaveDialog.open()
      }
      MenuItem {
        id: sessionRestoreVisibleItem
        text: "Restore Session"
        onTriggered: sessRestoreDialog.open()
      }
      MenuItem {
        id: colorControlVisibleItem
        text: "Display Settings"
        onTriggered: sessColorDialog.open()
      }
  
      MenuSeparator{}
      MenuItem { text: "Exit"; onTriggered: Qt.quit() }
    }
  }


  Button {
    text: "Start"  // Use text instead of tooltip
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignRight
        background: Rectangle {
      implicitWidth: 56
      implicitHeight: 40
      opacity: parent.pressed ? 0.3 : parent.checked ? 0.2 : 0.01
      color: 'white'
    }
    
    icon.source: (controller.enabled & (session.availableDevices > 0)) ? 'qrc:/icons/pause.png' : 'qrc:/icons/play.png'  // Changed from iconSource

    onClicked: {
      if (session.availableDevices > 0) {
        controller.toggle()
      }
    }
  }
}
