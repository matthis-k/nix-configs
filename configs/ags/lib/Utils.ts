const applications = await Service.import("applications")

export function getIconFromName(names: string[]) {
    let icon_name = "dialog-question-symbolic"
    for (let idx in names) {
        let name = names[idx]
        let matching_app = applications.query(name).at(0)
        if (matching_app && matching_app.icon_name) {
            icon_name = matching_app.icon_name
            break;
        }
    }
    return icon_name
}

export { }
