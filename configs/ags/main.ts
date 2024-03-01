import { Bar } from "modules/bar/main"
import { Wallpaper } from "modules/wallpaper/main"
import { Window } from "resource:///com/github/Aylur/ags/widgets/window.js"
import { Settings } from "modules/settings/main"
const hyprland = await Service.import("hyprland")


const scss = `${App.configDir}/style.scss`
const css = `/tmp/ags/style.css`
Utils.exec(`sassc ${scss} ${css}`)

Utils.monitorFile(scss, () => {
    Utils.exec(`sassc ${scss} ${css}`)
    App.resetCss()
    App.applyCss(css)
})

function per_monitor(callback: (monitor: number) => Window<any, unknown>): Window<any, unknown>[] {
    return Array.from(hyprland.monitors.map((monitor) => callback(monitor.id)))
}

App.config({
    style: css,
    windows: [...per_monitor(Bar), ...per_monitor(Wallpaper), Settings()]
})

export { }
