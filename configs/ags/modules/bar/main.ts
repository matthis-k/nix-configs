import { Workspaces } from "./workspace_taskbar"
import { Clock } from "./clock"
import { SystemStatus } from "./status"

// layout of the bar
function Left(monitor_id: number = 0) {
    return Widget.Box({
        class_name: "modules-left",
        spacing: 8,
        children: [
            Workspaces(monitor_id),
        ],
    })
}

function Center(monitor_id: number = 0) {
    return Widget.Box({
        class_name: "modules-center",
        spacing: 8,
        children: [
            Clock(),
        ],
    })
}

function Right(monitor_id: number = 0) {
    return Widget.Box({
        class_name: "modules-right",
        hpack: "end",
        spacing: 8,
        children: [
            SystemStatus()
        ],
    })
}

function Bar(monitor: number) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(monitor),
            center_widget: Center(monitor),
            end_widget: Right(monitor),
        }),
    })
}


export { Bar }
