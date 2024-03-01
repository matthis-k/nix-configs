import { get_active_monitor } from "lib/Utils"
import { dashboard } from "./dashboard";

class Status extends Service {
    static {
        Service.register(
            this, {},
            {
                'monitor': ['int', 'rw'],
                'visible': ['int', 'rw'],
            },
        );
    }

    #monitor = Variable(0);
    #visible = Variable(false);

    get monitor() {
        return this.#monitor;
    }

    get visible() {
        return this.#visible;
    }

    constructor() {
        super();
    }
}

const state = new Status

const WINDOW = Widget.Window({
    name: "settings",
    anchor: ["top", "bottom", "right"],
    exclusivity: "normal",
    layer: "top",
    monitor: state.monitor.bind(),
    keymode: "exclusive",
    visible: state.visible.bind(),
    child: Widget.EventBox({
        width_request: 500,
        child: Widget.Box({
            vertical: true,
            children: [
                Widget.Box({
                    hpack: "center",
                    spacing: 10,
                    vertical: false,
                    child: dashboard(),
                }),
            ],
        }),
    })
}).keybind([], "Escape", () => App.closeWindow("settings"))




export function toggle_settings(monitor_id: number = get_active_monitor()) {
    let new_visibility = monitor_id != state.monitor.value || !state.visible.value
    console.log(new_visibility)
    state.monitor.setValue(monitor_id)
    state.visible.setValue(new_visibility)
    if (state.visible.value) {
        App.openWindow("settings")
    } else {
        App.closeWindow("settings")
    }
}

export function Settings(monitor_id: number = 0) {
    WINDOW.monitor = monitor_id
    return WINDOW
}


export { }
