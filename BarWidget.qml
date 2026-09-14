import QtQuick
import Quickshell.Hyprland
import qs.Ui

BarWidget {
  id: root
  moduleName: "mark.scratchpad"

  readonly property string scratchpadName: "scratchpad"
  readonly property string scratchpadWorkspace: "special:" + scratchpadName
  readonly property int windowCount: countScratchpadWindows()

  function countScratchpadWindows() {
    var count = 0
    var toplevels = Hyprland.toplevels ? Hyprland.toplevels.values : []

    for (var i = 0; i < toplevels.length; i++) {
      var toplevel = toplevels[i]
      var workspace = toplevel ? toplevel.workspace : null
      if (workspace && String(workspace.name || "") === root.scratchpadWorkspace)
        count++
    }

    return count
  }

  function toggleScratchpad() {
    if (Hyprland.usingLua)
      Hyprland.dispatch("hl.dsp.workspace.toggle_special(\"" + root.scratchpadName + "\")")
    else
      Hyprland.dispatch("togglespecialworkspace " + root.scratchpadName)
  }

  // Keep Quickshell's model current for moves into and out of the scratchpad.
  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (!event || !event.name) return

      var name = String(event.name)
      if (name.indexOf("window") !== -1 || name.indexOf("workspace") !== -1) {
        Hyprland.refreshToplevels()
        Hyprland.refreshWorkspaces()
      }
    }
  }

  visible: windowCount > 0
  implicitWidth: visible ? button.implicitWidth : 0
  implicitHeight: barSize

  Behavior on implicitWidth {
    NumberAnimation { duration: 160; easing.type: Easing.OutCubic }
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\uf249"
    active: true
    horizontalMargin: 7.5
    tooltipText: root.windowCount === 1
      ? "Scratchpad: 1 window"
      : "Scratchpad: " + root.windowCount + " windows"

    onPressed: function(button) {
      if (button === Qt.LeftButton) root.toggleScratchpad()
    }
  }
}
