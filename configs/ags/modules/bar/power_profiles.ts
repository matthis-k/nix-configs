const powerProfiles = await Service.import('powerprofiles')

export function PowerProfiles() {
    const icon_name = powerProfiles.bind("icon_name")
    function get_classes() {
        return ["power-profiles", "applet", powerProfiles.active_profile]
    }

    return Widget.EventBox({
        class_names: Utils.watch(get_classes(), powerProfiles, get_classes),
        child: Widget.Icon({
            icon_name
        }),
        on_primary_click_release: () => {
            switch (powerProfiles.active_profile) {
                case 'balanced':
                    powerProfiles.active_profile = 'performance';
                    break;
                case 'performance':
                    powerProfiles.active_profile = 'power-saver';
                    break;
                default:
                    powerProfiles.active_profile = 'balanced';
                    break;
            };
        },
    })

}

export { }
