const audio = await Service.import("audio")
import Gtk from "gi://Gtk?version=3.0";
import { toggle_settings } from "modules/settings/main";

export function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }
    const reveal = Variable(false)

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon ?? 0]}-symbolic`
    }

    const icon = Widget.EventBox({
        child: Widget.Icon({
            icon: Utils.watch(getIcon(), audio.speaker, getIcon),
        }),
        on_secondary_click_release: () => {
            reveal.setValue(!reveal.value)
        },
        on_primary_click_release: () => {
            toggle_settings()
        },
    })

    const slider = Widget.Revealer({
        child: Widget.Slider({
            hexpand: true,
            vexpand: false,
            draw_value: false,
            valign: Gtk.Align.CENTER,
            width_request: 150,
            on_change: ({ value }) => audio.speaker.volume = value,
            setup: self => self.hook(audio.speaker, () => {
                self.value = audio.speaker.volume || 0
            }),
        }),
        reveal_child: reveal.bind(),
        transition: "slide_right",
        halign: Gtk.Align.CENTER,
        valign: Gtk.Align.CENTER,
    })

    const is_muted = audio.speaker.bind("is_muted")

    return Widget.CenterBox({
        class_names: is_muted.as((is_muted) => [is_muted ? "muted" : "", "audio", "applet"]),
        start_widget: icon,
        end_widget: slider,
    })
}

export { }
