import { Client } from "types/service/hyprland"
import { getIconFromName } from "lib/Utils"
import Gtk from "gi://Gtk?version=3.0";

const hyprland = await Service.import("hyprland")

function TaskbarClient(client: Client) {
    return Widget.Button({
        class_names: [`${hyprland.active.client.address == client.address ? "focused" : ""}`, "client"],
        child: Widget.Icon({
            width_request: 24,
            icon: getIconFromName([client.initialTitle, client.initialClass]),
            halign: Gtk.Align.CENTER,
            valign: Gtk.Align.CENTER,
        }),
        on_clicked: () => {
            if (hyprland.active.workspace.id == client.workspace.id) { return }
            hyprland.messageAsync(`dispatch focuswindow address:${client.address}`)
        },
        on_middle_click: () => {
            Utils.execAsync(`kill ${client.pid}`)
        }
    })
}

function Taskbar(workspace_id: number) {
    return Widget.Box({
        halign: Gtk.Align.CENTER,
        valign: Gtk.Align.CENTER,
        class_name: "taskbar",
        children: hyprland.clients.filter((client) => client.workspace.id == workspace_id).sort((a, b) => {
            if (a.initialClass == b.initialClass) { return 0 }
            else if (a.initialClass >= b.initialClass) { return 1 }
            else { return -1 }
        }).map(TaskbarClient),
    })
}

export function Workspaces(monitor_id: number = 0) {
    function getWorkspaces(monitor_id: number) {
        const show_always = Array.from({ length: 5 }).map((_, idx) => idx + 1 + (5 * monitor_id))
        const workspaces_in_use = hyprland.workspaces
            .filter((ws) => ws.windows > 0 || ws.id == hyprland.active.workspace.id)
            .map((ws) => ws.id)
        return [...new Set([...show_always, ...workspaces_in_use])].sort((a, b) => a - b)
    }
    const workspaces = Utils.watch(getWorkspaces(monitor_id), hyprland, () => getWorkspaces(monitor_id))
    const workspaces_widgets = workspaces.as((workspaces) => workspaces.map((id) => {
        return Widget.Box({
            class_names: [
                `${hyprland.clients.filter((client) => client.workspace.id == id).length == 0 ? "empty" : ""}`,
                `${hyprland.active.workspace.id == id ? "focused" : ""}`,
                "workspace",
                "module-lvl2"
            ],
            halign: Gtk.Align.CENTER,
            valign: Gtk.Align.CENTER,
            children: [
                Widget.Button({
                    on_clicked: () => {
                        if (hyprland.active.workspace.id == id) { return }
                        hyprland.messageAsync(`dispatch workspace ${id}`)
                    },
                    child: Widget.Label({ label: `${id}`, justification: "center" }),
                }),
                Taskbar(id),
            ],
        })
    }))

    return Widget.Box({
        spacing: 10,
        class_names: ["workspaces", "module-lvl1"],
        children: workspaces_widgets,
    })
}

export { }
